Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTKFUhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTKFUhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:37:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60678 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263808AbTKFUhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:37:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ide-scsi question: 2x
Date: 6 Nov 2003 12:37:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <boebdp$fm5$1@cesium.transmeta.com>
References: <20031106115813.GF25124@schottelius.org> <200311061558.40845.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200311061558.40845.bzolnier@elka.pw.edu.pl>
By author:    Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In newsgroup: linux.dev.kernel
>
> On Thursday 06 of November 2003 12:58, Nico Schottelius wrote:
> > Hello!
> 
> Hi,
> 
> > 1. why is printk used without KERN_* makro?
> >    like '        printk("[ ");' (267), ide-scsi from 2.6.0test9, version
> > 0.92 (there are more examples)
> 
> Because it was not updated to use KERN_*?
> 

Unfortunately the interface is a bit braindead.  KERN_* only applies
to the beginning of a line.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
