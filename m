Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSLHNqe>; Sun, 8 Dec 2002 08:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSLHNqe>; Sun, 8 Dec 2002 08:46:34 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:44215 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261312AbSLHNqd>; Sun, 8 Dec 2002 08:46:33 -0500
Subject: Re: lilo append mem problem in 2.4.20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: GertJan Spoelman <kl@gjs.cc>
Cc: rtilley <rtilley@vt.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212081202.32754.kl@gjs.cc>
References: <3DFDE59F@zathras>  <200212081202.32754.kl@gjs.cc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 14:30:20 +0000
Message-Id: <1039357820.6912.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 11:02, GertJan Spoelman wrote:
>         append="mem=exactmap mem=640K@0 mem=319M@1M"
> to get the kernel to see all the memory.
> So probably you can get it working again with:
>         append="mem=exactmap mem=640K@0 mem=1023M@1M"
> Maybe you also could do directly: exactmap mem=1024M@0
> or 1G@0, but I haven't tried that yet.
> It seems the mem parameter now only can be used to limit the amount of memory 
> used by the kernel.

Without exactmap yes (fixed in 2.4.19 I believe). Also on many compaqs
you can set the OS in the BIOS to "unixware" and get sane results
