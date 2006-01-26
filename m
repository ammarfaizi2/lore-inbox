Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWAZTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWAZTQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWAZTQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:16:02 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:13223 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964814AbWAZTP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:15:59 -0500
Date: Thu, 26 Jan 2006 11:14:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Pavel Machek <pavel@suse.cz>
Cc: mita@miraclelinux.com, linux-kernel@vger.kernel.org, rth@twiddle.net,
       ink@jurassic.park.msu.ru, rmk@arm.linux.org.uk, spyro@f2s.com,
       dev-etrax@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp,
       torvalds@osdl.org, linux-ia64@vger.kernel.org, takata@linux-m32r.org,
       linux-m68k@vger.kernel.org, gerg@uclinux.org, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp, ak@suse.de,
       chris@zankel.net
Subject: Re: [PATCH 1/6] {set,clear,test}_bit() related cleanup
Message-Id: <20060126111419.54b1cc56.pj@sgi.com>
In-Reply-To: <20060126161426.GA1709@elf.ucw.cz>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125112857.GB18584@miraclelinux.com>
	<20060126161426.GA1709@elf.ucw.cz>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel wrote:
> cpu_set sounds *very* ambiguous. We have thing called cpusets,

Hmmm ... you're right.  I've worked for quite some time on both
of these, and hadn't noticed this similarity before.

Oh well.  Such is the nature of naming things.  Sometimes nice
names resemble other nice names in unexpected ways.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
