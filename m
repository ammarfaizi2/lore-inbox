Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSJMI4F>; Sun, 13 Oct 2002 04:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbSJMI4F>; Sun, 13 Oct 2002 04:56:05 -0400
Received: from dp.samba.org ([66.70.73.150]:39593 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261474AbSJMI4E>;
	Sun, 13 Oct 2002 04:56:04 -0400
Date: Sun, 13 Oct 2002 18:59:38 +1000
From: Anton Blanchard <anton@samba.org>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
Cc: "'Rob Mueller'" <robm@fastmail.fm>,
       "'Mark Hahn'" <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org,
       "'Jeremy Howard'" <jhoward@fastmail.fm>
Subject: Re: Strange load spikes on 2.4.19 kernel
Message-ID: <20021013085938.GA23575@krispykreme>
References: <113001c27282$93955eb0$1900a8c0@lifebook> <000001c27286$6ab6bc60$7443f4d1@joe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c27286$6ab6bc60$7443f4d1@joe>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'll let you in on a dirty little secret.  The Linux file system does
> not utilize SMP.  That's right.  All file processes go through one and
> only one processor.  It has to do with the fact that the Linux kernel is
> a non-preemptive kernel.

My 24 way SMP disagrees with your analysis:

http://samba.org/~anton/linux/2.5.40/dbench/

Thats just ext2. dbench is a filesystem benchmark that is heavy on
inode/block allocation.

Please show us your profiles which show linux filesystems do not
utilise SMP.

Anton
