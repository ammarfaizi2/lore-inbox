Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUCDV4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUCDV4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:56:19 -0500
Received: from mho.net ([64.58.22.200]:54708 "EHLO es1036.belits.com")
	by vger.kernel.org with ESMTP id S261951AbUCDV4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:56:14 -0500
Date: Thu, 4 Mar 2004 14:51:03 -0700 (MST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
X-X-Sender: abelits@es1840.belits.com
To: David Eger <eger@havoc.gtf.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UTF-8ifying the kernel source
In-Reply-To: <20040304100503.GA13970@havoc.gtf.org>
Message-ID: <Pine.LNX.4.58.0403041448320.18073@es1840.belits.com>
References: <20040304100503.GA13970@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, David Eger wrote:

> http://www.yak.net/random/linux-2.6.3-utf8-cleanup-auto.diff.bz2
>
> Here you find the first of several patches to convert the kernel
> source from ISO Latin-1 to UTF-8.  I'm working on the files that didn't
> auto-convert easily; comments welcome ;-)
>
> First, some statistics!
>
> In Linux 2.6.3, there are:
> 15860 clean 7-bit ASCII files
> 274 text files are not 7-bit clean
>
> 38 of these 274 files are not auto-convertible -- either they are not ISO
> Latin-1 or the high octets appear within the actual code (not comments).
>
> This first patch applies to help files, documentation, and comments which
> are trivially correct ISO Latin-1 => UTF-8 conversions.  The work I have
> left to do is summarized below.

  That will be of a great help for the future developers that will edit
kernel sources in Microsoft Word.

[a large collection of expletives in multiple languages and charsets is
skipped here]

-- 
Alex
