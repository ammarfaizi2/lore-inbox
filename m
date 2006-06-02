Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWFBR1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWFBR1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWFBR1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:27:42 -0400
Received: from mail.enyo.de ([212.9.189.167]:30402 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750809AbWFBR1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:27:41 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Brian F. G. Bidulock" <bidulock@openss7.org>
Subject: Re: Question about tcp hash function tcp_hashfn()
References: <20060531090301.GA26782@2ka.mipt.ru>
	<20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru>
	<20060531.114127.14356069.davem@davemloft.net>
	<20060601060424.GA28087@2ka.mipt.ru>
	<87y7wgaze1.fsf@mid.deneb.enyo.de>
	<20060602074845.GA17798@2ka.mipt.ru>
Date: Fri, 02 Jun 2006 19:26:53 +0200
In-Reply-To: <20060602074845.GA17798@2ka.mipt.ru> (Evgeniy Polyakov's message
	of "Fri, 2 Jun 2006 11:48:46 +0400")
Message-ID: <87ac8v8o4i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Evgeniy Polyakov:

> :) thats true, but to be 100% honest I used different code to test for
> hash artifacts...

Ah, okay.

> But it still does not fix artifacts with for example const IP and random
> ports or const IP and linear port selection.

I see them now.  Hmm.  Is there a theoretical explanation for them?
