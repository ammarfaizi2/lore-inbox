Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVKNBLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVKNBLR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 20:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKNBLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 20:11:17 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:21708 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750816AbVKNBLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 20:11:17 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
To: Andi Kleen <ak@suse.de>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Reply-To: 7eggert@gmx.de
Date: Mon, 14 Nov 2005 01:33:18 +0100
References: <57CC5-7cD-21@gated-at.bofh.it> <57CC5-7cD-19@gated-at.bofh.it> <58gSR-6FB-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EbSHf-0007LU-4t@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:

> Matt Mackall <mpm@selenic.com> writes:
> 
>> This adds configurable support for doublefault reporting on x86
> 
> I think that's a bad idea. Users will disable it and then
> send bad bug reports. Better bug reports are worth 4K.

depends on EMBEDDED?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
