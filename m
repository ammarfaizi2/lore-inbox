Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUF2V3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUF2V3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266079AbUF2V3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:29:25 -0400
Received: from mail.enyo.de ([212.9.189.167]:17671 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266075AbUF2V2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:28:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
References: <40DC9B00@webster.usu.edu>
	<20040625150532.1a6d6e60.davem@redhat.com>
	<cbp62t$a38$1@news.cistron.nl>
	<20040629043411.A5054@homebase.cluenet.de>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 29 Jun 2004 23:28:42 +0200
In-Reply-To: <20040629043411.A5054@homebase.cluenet.de> (Daniel Roesen's
 message of "Tue, 29 Jun 2004 04:34:11 +0200")
Message-ID: <87zn6myrxx.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Roesen:

> Not if the MD5 option is properly implemented - i.e. MD5 hash checking
> is done AFTER the packet is considered valid in terms of "fitting"
> sequence number.

In this case, you trade robustness against network load for robustness
against implementation errors.  I'd rather not to have to make this
choice. 8-/
