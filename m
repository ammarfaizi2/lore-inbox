Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUD1QOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUD1QOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 12:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUD1QOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 12:14:53 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:23232 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S264917AbUD1QO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:14:27 -0400
From: Goran Cengic <cengic@s2.chalmers.se>
Organization: Chalmers University of Technology
To: linux-kernel@vger.kernel.org
Subject: Special place for tird-party modules.
Date: Wed, 28 Apr 2004 18:14:24 +0200
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404281814.24991.cengic@s2.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The other day I installed some newly compiled modules with "make 
modules_install" from the source three and that action removed already 
installed nvidia kernel module so I had to rebuild and install it again.

This leads to following question:

I know that kernel can be compiled so that it cant load different versions of 
the modules (it says so in the help text of the kernel configuration). How 
come then there is no special place, say /lib/modules/local, for third-party 
modules so that they can be installed just by copying them there from the 
distribution archive and doing whatever configuration needed from there on? 

This way hardware vendors could just compile the module and distribute it in 
the binary form. This would also make it easy to upgrade the kernel without 
having to reinstall all the drivers. What are arguments for and against this 
approach? Why does the nvidia driver have to be compiled for different kernel 
versions? Can't they make one module that fits all kernels?

Another question is, if there is a way to compile kernel that loads modules of 
different versions, why are the modules still installed in 
"/lib/modules/`uname -r`/*" instead of "/lib/modules/*" by default? In another 
words. Why is it necessary to upgrade modules with every kerenel release even 
though some of them might not be in the need there of?

I do understand that many developers have several kernel version installed at 
the same time but is it possible to share between the versions at least the 
modules that are not developed as the part of the kernel?

If I'm missing something cruical please point it out to me.

Thanks in advance.

/Goran

mailto:cengic@s2.chalmers.se
Have a nice day :)
