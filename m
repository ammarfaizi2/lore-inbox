Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263020AbTCSNFL>; Wed, 19 Mar 2003 08:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263022AbTCSNFL>; Wed, 19 Mar 2003 08:05:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29827
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263020AbTCSNFK>; Wed, 19 Mar 2003 08:05:10 -0500
Subject: Re: Linux on 16-bit processors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: micklweiss@gmx.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <17232.1048031207@www59.gmx.net>
References: <17232.1048031207@www59.gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048084009.30751.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Mar 2003 14:26:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 23:46, micklweiss@gmx.net wrote:
> I'm interested on running Linux on some less powerful, cheaper 16 bit
> systems. I would like to know if there is a slimmed down version of the kernel (any
> version 2.2+) that can run on 16-bit CPUs. I know that linux "requires" a

The kernel side is fairly easy if you have a couple of megs of ram. The
ucLinux tree supports mmuless systems and a fair variety of processors. 
User space is more of an issue. The standard Linux userspace is designed
for systems with disks and paging, the uclinux stuff is smaller and the
ELKS userspace is tinier still.

And uclinux is free not $200. Maybe the writer is confused with the 
ucSimm development board ?

BTW are "real" 16bit processors actually cheaper any more ? 16bit keeps
costs down but several 683xx processors seem to use 16bit external
data bus as do some ARM.


Alan

