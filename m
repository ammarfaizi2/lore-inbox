Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbSKSGnF>; Tue, 19 Nov 2002 01:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSKSGnF>; Tue, 19 Nov 2002 01:43:05 -0500
Received: from rj.sgi.com ([192.82.208.96]:47300 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S267115AbSKSGnE>;
	Tue, 19 Nov 2002 01:43:04 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch: module-init-tools-0.6/modprobe.c - support subdirectories 
In-reply-to: Your message of "Tue, 19 Nov 2002 17:42:38 +1100."
             <20021119064333.C5C1C2C2C4@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Nov 2002 17:49:56 +1100
Message-ID: <14079.1037688596@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002 17:42:38 +1100, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>In message <20021118073247.A10109@adam.yggdrasil.com> you write:
>> 	The following untested patch adds subdirectory support to
>> module-init-tools-0.6/modprobe.c.  I really need this for tools that I
>> use for building initial ramdisks to do things like select all SCSI
>> and IDE drivers without having to release a new version of the ramdisk
>> maker every time a new SCSI or IDE driver is added.  The patch is a net
>> addition of four lines to modprobe.c.
>
>Hmm, I'm not entirely convinced.  Moving back into subdirs introduces
>a namespace which isn't really there.  However, as you say, it's
>trivial.

mkinitrd.
modprobe -l -t scsi.

