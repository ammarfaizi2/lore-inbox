Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265599AbSJSMSD>; Sat, 19 Oct 2002 08:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265598AbSJSMSD>; Sat, 19 Oct 2002 08:18:03 -0400
Received: from dp.samba.org ([66.70.73.150]:4573 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265599AbSJSMSC>;
	Sat, 19 Oct 2002 08:18:02 -0400
Date: Sat, 19 Oct 2002 22:22:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
Message-ID: <20021019122236.GA3545@krispykreme>
References: <3DA798B6.9070400@us.ibm.com> <20021012035141.GC7050@krispykreme> <20021012035958.GD10722@holomorphy.com> <20021012040959.GE7050@krispykreme> <3DA9C896.621CC3D3@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA9C896.621CC3D3@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Half of which is in timer.c.
> 
> mnm:/usr/src/25> size kernel/timer.o
>    text    data     bss     dec     hex filename
>    4960     100  167648  172708   2a2a4 kernel/timer.o
> 
> That's with NR_CPUS=32.  Show me yours.

Its not like me to miss show and tell.

CONFIG_NR_CPUS=32:
text	   data	    bss	    dec	    hex	filename
8488	 267544	  71392	 347424	  54d20	kernel/timer.o

CONFIG_NR_CPUS=64:
text	   data	    bss	    dec	    hex	filename
8488	 533784	 137568	 679840	  a5fa0	kernel/timer.o

Ouch.

Anton
