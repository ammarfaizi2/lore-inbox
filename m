Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTKMUWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 15:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264421AbTKMUWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 15:22:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8211 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264419AbTKMUWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 15:22:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: OT: why no file copy() libc/syscall ??
Date: 13 Nov 2003 12:22:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bp0p5m$lke$1@cesium.transmeta.com>
References: <1068512710.722.161.camel@cube> <20031111133859.GA11115@bitwizard.nl> <20031111085323.M8854@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031111085323.M8854@devserv.devel.redhat.com>
By author:    Jakub Jelinek <jakub@redhat.com>
In newsgroup: linux.dev.kernel
> > 
> > Actually, I think we should have a: 
> > 
> > 	long copy_fd_to_fd (int src, int dst, int len)
> > 
> > type of systemcall. 
> 
> We have one, sendfile(2).
> 

It would be very nice if we could (a) expand the uses of sendfile(2),
and (b) have the libc do the fallback to read/write/mmap as needed.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
