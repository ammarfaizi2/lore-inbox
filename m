Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVKTU5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKTU5p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 15:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVKTU5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 15:57:45 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:21692 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750776AbVKTU5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 15:57:44 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
To: Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <daniel.marjamaki@comhem.se>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 20 Nov 2005 21:58:46 +0100
References: <5aZsv-3CJ-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EdwGs-0000qv-NL@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Marjamäki <daniel.marjamaki@comhem.se> wrote:

> -     aztTimeOutCount = 0;
> +     aztTimeOut = jiffies + 2;

Different timeout based on HZ seems wrong.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
