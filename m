Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278625AbRKSMv4>; Mon, 19 Nov 2001 07:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278630AbRKSMvq>; Mon, 19 Nov 2001 07:51:46 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:3847 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278625AbRKSMvm>;
	Mon, 19 Nov 2001 07:51:42 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: brett@bad-sports.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops 1 of 2, try_to_release_page, 2.4.9-13 
In-Reply-To: Your message of "Mon, 19 Nov 2001 21:53:44 +1100."
             <Pine.LNX.4.40.0111192151580.14019-100000@bad-sports.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Nov 2001 23:51:31 +1100
Message-ID: <5710.1006174291@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001 21:53:44 +1100 (EST), 
brett@bad-sports.com wrote:
>ksymoops 2.4.1 on i686 2.4.9-13.  Options used
>Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
>Error (expand_objects): cannot stat(/lib/jbd.o) for jbd

When booting from initrd, you need to run 'ksymoops -i' in order to
find the real objects.

>Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says d2983d14, /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o says d298317c.  Ignoring /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o entry

ksymoops bug, upgrade to ksymoops 2.4.3.  It probably does not affect
this decode but it will affect others.

