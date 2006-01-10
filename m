Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWAJPPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWAJPPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWAJPPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:15:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36796 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751113AbWAJPPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:15:18 -0500
Message-ID: <43C3CF3D.4000701@sgi.com>
Date: Tue, 10 Jan 2006 09:14:05 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@infradead.org, sam@ravnborg.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
References: <20060109164214.GA10367@mars.ravnborg.org>	<20060109164611.GA1382@infradead.org>	<43C2CFBD.8040901@sgi.com> <20060109234532.78bda36a.akpm@osdl.org>
In-Reply-To: <20060109234532.78bda36a.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It'd be nice to fix this:
> 
> bix:/usr/src/25> make fs/xfs/linux-2.6/xfs_iops.o
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   SHIPPED scripts/genksyms/lex.c
>   SHIPPED scripts/genksyms/parse.h
>   SHIPPED scripts/genksyms/keywords.c
>   HOSTCC  scripts/genksyms/lex.o
>   SHIPPED scripts/genksyms/parse.c
>   HOSTCC  scripts/genksyms/parse.o
>   HOSTLD  scripts/genksyms/genksyms
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/modpost.o
>   HOSTLD  scripts/mod/modpost
> scripts/Makefile.build:15: /usr/src/devel/fs/xfs/linux-2.6/Makefile: No such file or directory
> make[1]: *** No rule to make target `/usr/src/devel/fs/xfs/linux-2.6/Makefile'.  Stop.
> make: *** [fs/xfs/linux-2.6/xfs_iops.o] Error 2

I'll see what I can do to fix this up and a couple of other kbuild issues I've 
run into recently.

Thanks,

-Eric
