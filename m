Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbTFSGC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265495AbTFSGC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:02:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17165 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265474AbTFSGC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:02:28 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: glibc compiling with kernel 2.5.70-bk17
Date: 18 Jun 2003 23:16:00 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bcrkf0$dsf$1@cesium.transmeta.com>
References: <3EF10F3E.1090308@cern.ch> <3EF11080.5060507@cox.net> <3EF12031.8020709@hereintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3EF12031.8020709@hereintown.net>
By author:    Chris Meadors <clubneon@hereintown.net>
In newsgroup: linux.dev.kernel
> 
> Your first comment is something I had wondered about for a while. A 
> stable set of userspace kernel headers. That would be nice.  Of course 
> changes could be made to reflect new kernel interfaces.  So they should 
> still be distributed with the kernel source.  Then glibc could be 
> compiled against those updates, and the headers installed as the system 
> default.  But it wouldn't be so forbidden for userspace to touch them.
> 

Yes, this is the "ABI headers" project that has been discussed
extensively on this list.  It's pretty important, but unlikely to
happen in time for 2.6.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
