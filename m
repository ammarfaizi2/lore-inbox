Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbTCEBt2>; Tue, 4 Mar 2003 20:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTCEBt2>; Tue, 4 Mar 2003 20:49:28 -0500
Received: from tapu.f00f.org ([202.49.232.129]:18846 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S266865AbTCEBt1>;
	Tue, 4 Mar 2003 20:49:27 -0500
Date: Tue, 4 Mar 2003 17:59:57 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Daniel Egger <degger@fhm.edu>, linux-kernel@vger.kernel.org
Subject: Re: Kernel bloat 2.4 vs. 2.5
Message-ID: <20030305015957.GA27985@f00f.org>
References: <1046817738.4754.33.camel@sonja> <20030304154105.7a2db7fa.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304154105.7a2db7fa.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 03:41:05PM -0800, Andrew Morton wrote:

> Daniel Egger <degger@fhm.edu> wrote:

> > I've seen surprisingly few messages about the dramatic size
> > increase between a simple 2.4 and a 2.5 kernel image.

> 2.4 has magical size reduction tricks in it which were not brought
> into 2.5 because we expect that gcc will do it for us.

I can't see it helping *that* much, for me I have:

    charon:~/wk/linux% size 2.4.x-cw/vmlinux bk-2.5.x/vmlinux
       text    data     bss     dec     hex filename
    2003887  120260  191657 2315804  23561c 2.4.x-cw/vmlinux
    2411323  267551  181004 2859878  2ba366 bk-2.5.x/vmlinux

    gcc version 2.95.4 20011002 (Debian prerelease)

this is for functionally (in terms of .config) equivalent kernels.


  --cw
