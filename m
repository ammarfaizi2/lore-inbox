Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbSLKTft>; Wed, 11 Dec 2002 14:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267293AbSLKTfs>; Wed, 11 Dec 2002 14:35:48 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:61230 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267278AbSLKTfq>;
	Wed, 11 Dec 2002 14:35:46 -0500
Date: Wed, 11 Dec 2002 20:43:21 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: TomF <TomF@sjpc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mounting udf DVD-RAM changes owner
Message-ID: <20021211194321.GA10110@win.tue.nl>
References: <20021211000033.3b9fe22a.TomF@sjpc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211000033.3b9fe22a.TomF@sjpc.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 12:00:33AM -0800, TomF wrote:

> Before I mount a udf cartridge, I get
> 
> [Tom@localhost Tom]$ ls -l /mnt
> ...
> drwxr-xr-x    2 Tom      root         4096 Nov  5 11:20 dvd
> 
> [Tom@localhost Tom]$ mount /mnt/dvd
> [Tom@localhost Tom]$ ls -l /mnt
> ...
> drwxr-xr-x    4 root     root          140 Dec  6 19:13 dvd

Read mount(8), especially the sentence

       The
       previous contents (if any)  and  owner  and  mode  of  dir
       become  invisible, and as long as this file system remains
       mounted, the pathname dir refers to the root of  the  file
       system on device.

