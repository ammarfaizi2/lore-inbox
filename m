Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752378AbVHGRH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbVHGRH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbVHGRHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:07:25 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:6793 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752378AbVHGRHZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:07:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OH3kiu1ED+OpUFKT56BlDRw/8jL04OIdmBTNBHktgtyIRdnqV08QRe0PhoIs5PLyUpK2Vvljrn6xXehFwCV6SIdwnHQxm5K/ywphnA8w88idS0zIkFCHSZbUNBlujql260NPSUjscWJmpNSEaHOaENKmBDnabEG4nrY47w8XVLY=
Message-ID: <5348b8ba050807100770f6b9c6@mail.gmail.com>
Date: Sun, 7 Aug 2005 13:07:24 -0400
From: Erick Turnquist <jhujhiti@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
In-Reply-To: <p73mznuc732.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel>
	 <p73mznuc732.fsf@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's most likely bad SMM code in the BIOS that blocks the CPU too long
> and is triggered in idle. 

Might a BIOS flash help, or is this something that's there to stay?

> No way to fix this, but you can work around it with very new kernels
> by compiling with a lower HZ than 1000.

Actually, it was already running at 250Hz. I must have turned it down
a while ago while I was trying to find the cause of the problem.
