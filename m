Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132507AbRDKAne>; Tue, 10 Apr 2001 20:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDKAnO>; Tue, 10 Apr 2001 20:43:14 -0400
Received: from wirex.com ([208.161.110.91]:8971 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S132502AbRDKAnL>;
	Tue, 10 Apr 2001 20:43:11 -0400
Message-ID: <3AD3A86A.6ACD8B05@wirex.com>
Date: Tue, 10 Apr 2001 17:42:18 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18-1_imnx_5_crispin i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux Security Module Interface
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the byproducts of the Linux 2.5 Kernel Summit
http://lwn.net/2001/features/KernelSummit/ was the notion of an
enhancement of the loadable kernel module interface to facilitate
security-oriented kernel modules.  The purpose is to ease the tension
between folks (such as Immunix and SELinux) who want to add substantial
security capabilities to the kernel, and other folks who want to
minimize kernel bloat & have no use for such security extensions.

Modules that can be loaded, or not, are the obvious solution, but the
current LKM does not export sufficient hooks to support many security
mechanisms.  Thus many current security enhancements end up existing as
kernel patches, which marginalizes their utility by making distribution
problematic. The proposed solution is to enhance the LKM with a variety
of new kernel elements exported to the module interface, so as to
support a reasonable variety of security enhancements.

We have started a new mailing list called linux-security-module.  The
charter is to design, implement, and maintain suitable enhancements to
the LKM to support a reasonable set of security enhancement packages.
The prototypical module to be produced would be to port the POSIX Privs
code out of the kernel and make it a module.  An essential part of this
project will be that the resulting work is acceptable for the mainline
Linux kernel.

The list is open to all.  You can subscribe here
http://mail.wirex.com/mailman/listinfo/linux-security-module or by
sending e-mail to linux-security-module-request@wirex.com with a subject
of "subscribe".

Crispin

--
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org



