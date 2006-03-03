Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWCCLw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWCCLw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWCCLw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:52:57 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:27015 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750848AbWCCLw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:52:57 -0500
Message-ID: <44082E14.5010201@drzeus.cx>
Date: Fri, 03 Mar 2006 12:52:52 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@vrfy.org>
CC: ambx1@neo.rr.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org>
In-Reply-To: <20060302165816.GA13127@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:
>
> Sorry, but your patch is just incomplete and in some cases just wrong.
> On my new ThinkPad, 3 of 12 devices would not work with your patch, so this
> is far from "most common" and not acceptable. So eighter we get a fully
> working modalias or we better stay without one for PNP and handle that
> with the custom script we already use today.
>
>   

Well then you shouldn't have any problems with adding multi-line support
of modalias in udev. Then I can do another patch that exports all aliases.

Rgds
Pierre

