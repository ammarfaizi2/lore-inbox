Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbUALVFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbUALVFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:05:15 -0500
Received: from main.gmane.org ([80.91.224.249]:42965 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265626AbUALVDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:03:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: Re: oops with config_pnpbios enabled.
Date: Mon, 12 Jan 2004 22:03:22 +0100
Message-ID: <28264810.mKCE9dZzCJ@spamfreemail.de>
References: <20040112184132.GC1686@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Bruno Leitner wrote:

> 
> 
> Hi!
> 
> Updating to 2.6.1 two machines returns a oops during boot.
> They can boot if disable CONFIG_PNPBIOS.
> 
> AFAIK, PNPBIOS is important to get some areas that are
> reserved by BIOS, so I think leaving this option disabled
> is a mistake.
> 
> I will compile 2.6.0 asap to check if this happens too.

I had this problem since 2.6.0-test11 (first one I tried), on my laptop.
I posted about this here as well. I was told to disable PNPBIOS and
LOCAL_APIC, which worked (so far).

All the desktops (three) I've tried so far didn't have a problem with or
without PNPBIOS.



-- 
Jens Benecke
