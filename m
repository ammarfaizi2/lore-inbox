Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTAVWLx>; Wed, 22 Jan 2003 17:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTAVWLx>; Wed, 22 Jan 2003 17:11:53 -0500
Received: from [213.86.99.237] ([213.86.99.237]:54510 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264628AbTAVWLw>; Wed, 22 Jan 2003 17:11:52 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.96.1030122133330.3958B-100000@gatekeeper.tmr.com> 
References: <Pine.LNX.3.96.1030122133330.3958B-100000@gatekeeper.tmr.com> 
To: Bill Davidsen <davidsen@tmr.com>
Cc: Olaf Titz <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Jan 2003 22:17:41 +0000
Message-ID: <27680.1043273861@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davidsen@tmr.com said:
>  `uname -r` is the kernel version of the running kernel. It is NOT by
> magic the kernel version of the kernel you are building... 

Er, yes. And what's your point? 

There is _no_ magic that will find the kernel you want to build against
today without any input from you. Using the build tree for the
currently-running kernel, if installed in the standard place, is as good a
default as any. Of course you should be permitted to override that default.

You remain free to put your build trees wherever you want -- with the
obvious proviso that if you put them somewhere other than the standard
place, you need to tell the out-of-tree build process where to find the tree
you want to build against. This seems to be entirely irrelevant to the
original question. 

--
dwmw2


