Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWHBCM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWHBCM3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWHBCM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:12:28 -0400
Received: from web36713.mail.mud.yahoo.com ([209.191.85.47]:59223 "HELO
	web36713.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751001AbWHBCM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:12:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IqpQc/dhQZylNsLENTdyUY9rlc3sCG+uKZsXODJHnWterXvm3cdF75QYHwIidnxnUHS2HwrBIX/IgMK7PrwWcQ1cliLeq3pmzFn/ud5e4zwWcszUNjuQ7HFsc4S/Vt/0FS3KRDR9A0HvQnu1SJpOVQkF2vMRklgKxbjmye3iUd8=  ;
Message-ID: <20060802021227.19174.qmail@web36713.mail.mud.yahoo.com>
Date: Tue, 1 Aug 2006 19:12:27 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44CE3FC0.6080500@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was working on making some sense from all the
constants and discovered that many flashmedia mmc
registers are very similar in bit assignment to OMAP
mmc ones (which are documented). Pity I haven't
noticed it before. I'll take some time now to review
the driver given this new information.


> Ah, ok, I see. The socket structure would then be
> similar to a device
> structure in the kernel. Perhaps you should use the
> name "host" instead
> of "card" then as that is widely used in the other
> mmc host drivers.

But what with mmc_host structure that also hangs
around? I think it deserves the name "host" even more.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
