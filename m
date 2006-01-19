Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWASMoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWASMoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 07:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWASMoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 07:44:11 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:32446 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751408AbWASMoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 07:44:11 -0500
Date: Thu, 19 Jan 2006 13:50:56 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Roman Zippel <zippel@linux-m68k.org>
cc: 7eggert@gmx.de, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-Reply-To: <Pine.LNX.4.61.0601191250330.11765@scrub.home>
Message-ID: <Pine.LNX.4.58.0601191328240.2205@be1.lrz>
References: <5roZI-5y9-29@gated-at.bofh.it> <5sSVt-5Du-1@gated-at.bofh.it>
 <5sWwg-2Bq-21@gated-at.bofh.it> <5t4kf-5Px-11@gated-at.bofh.it>
 <5t5zv-7GD-31@gated-at.bofh.it> <5tXA1-3Lh-35@gated-at.bofh.it>
 <5u04G-7s6-19@gated-at.bofh.it> <5u8Yt-317-41@gated-at.bofh.it>
 <5u9L8-4gd-19@gated-at.bofh.it> <5uadH-4TM-1@gated-at.bofh.it>
 <5uaQp-5UL-7@gated-at.bofh.it> <5ubjI-6KH-21@gated-at.bofh.it>
 <5ubtB-6Xy-9@gated-at.bofh.it> <5uBdT-2Gn-23@gated-at.bofh.it>
 <E1EzLCy-0001uG-7x@be1.lrz> <Pine.LNX.4.61.0601191250330.11765@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Roman Zippel wrote:
> On Wed, 18 Jan 2006, Bodo Eggert wrote:

> > > It means it will accept any input and no input (by just pressing enter or
> > > ctrl-d) means the default answer.
> > 
> > If I press ^D, I'd expect to select the abort option
> 
> That would be ^C. ^D means end-of-file and it's up to the application, 
> whether it needs further information to continue or not.

If it does need data, it SHOULD NOT invent it, especially if inventing
this data has no benefit and causes unexpected beahviour and random 
breakage.

-- 
Top 100 things you don't want the sysadmin to say:
66. What do you mean you needed that directory?
