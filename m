Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbTDHW5h (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbTDHW5g (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:57:36 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:55197 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262478AbTDHW50 convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:57:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>, Alistair Strachan <alistair@devzero.co.uk>
Subject: Re: 2.5.67-mm1
Date: Tue, 8 Apr 2003 16:06:13 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200304081741.10129.alistair@devzero.co.uk> <20030408142853.74709a82.akpm@digeo.com>
In-Reply-To: <20030408142853.74709a82.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304081606.13405.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 April 2003 02:28 pm, Andrew Morton wrote:
> Alistair Strachan <alistair@devzero.co.uk> wrote:
> > On attempting to boot this kernel, I get the following just before init:
> > Kernel panic: VFS: Unable to mount root fs on 03:05
> >
> > 2.5.67 base works fine. I discovered that reverting the following
> > patches allows me to boot. I can increase the granularity of my search
> > if nothing comes immediately to mind:
> >
> > aggregated-disk-stats.patch
> > dynamic-hd_struct-allocation-fixes.patch
> > dynamic-hd_struct-allocation.patch
>
> Ah, good detective work, thanks.  It looks like the hd_struct dynamic
> allocation patch has broken devfs partition discovery somehow.

Thanks.. I am going to look now. Must have broken something in devfs.

- Badari
