Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRDKCa3>; Tue, 10 Apr 2001 22:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRDKCaU>; Tue, 10 Apr 2001 22:30:20 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:24587 "HELO
	mail5.speakeasy.net") by vger.kernel.org with SMTP
	id <S129346AbRDKCaC>; Tue, 10 Apr 2001 22:30:02 -0400
Message-ID: <3AD3C1CC.D6167000@megapathdsl.net>
Date: Tue, 10 Apr 2001 19:30:36 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5 module development mailing list needed?  [Fwd: Linux Security Module 
 Interface]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since the 2.5 kernel development will require continued module
architecture changes to accomodate power management, pluggable
security and PCMCIA in the kernel tree, it would seem to make
sense that the various groups that are doing module related
architecture changes collaborate and be aware of what each
other are doing, so that changes can be coordinated.

Groups that contain individuals who might be interested 
might include:  

	acpi@phobos.fs.tum.de
	linux-hotplug-devel@lists.sourceforge.net
	linux-power@phobos.fs.tum.de
	linux-security-module@wirex.com
	LKML

Comments?

	Miles

Crispin Cowan wrote:
> 
> One of the byproducts of the Linux 2.5 Kernel Summit
> http://lwn.net/2001/features/KernelSummit/ was the notion of an
> enhancement of the loadable kernel module interface to facilitate
> security-oriented kernel modules.  The purpose is to ease the tension
> between folks (such as Immunix and SELinux) who want to add substantial
> security capabilities to the kernel, and other folks who want to
> minimize kernel bloat & have no use for such security extensions.
> 
> Modules that can be loaded, or not, are the obvious solution, but the
> current LKM does not export sufficient hooks to support many security
> mechanisms.  Thus many current security enhancements end up existing as
> kernel patches, which marginalizes their utility by making distribution
> problematic. The proposed solution is to enhance the LKM with a variety
> of new kernel elements exported to the module interface, so as to
> support a reasonable variety of security enhancements.
> 
> We have started a new mailing list called linux-security-module.  The
> charter is to design, implement, and maintain suitable enhancements to
> the LKM to support a reasonable set of security enhancement packages.
> The prototypical module to be produced would be to port the POSIX Privs
> code out of the kernel and make it a module.  An essential part of this
> project will be that the resulting work is acceptable for the mainline
> Linux kernel.
> 
> The list is open to all.  You can subscribe here
> http://mail.wirex.com/mailman/listinfo/linux-security-module or by
> sending e-mail to linux-security-module-request@wirex.com with a subject
> of "subscribe".
