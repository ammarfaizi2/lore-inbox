Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWG0SHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWG0SHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWG0SHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:07:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48361 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751910AbWG0SHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:07:20 -0400
Subject: Re: Require mmap handler for a.out executables
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: 7eggert@gmx.de
Cc: Marcel Holtmann <marcel@holtmann.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eugene Teo <eteo@redhat.com>
In-Reply-To: <E1G69zn-0001Wb-66@be1.lrz>
References: <6COYh-8f0-41@gated-at.bofh.it>  <E1G69zn-0001Wb-66@be1.lrz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 19:25:52 +0100
Message-Id: <1154024752.13509.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 19:49 +0200, ysgrifennodd Bodo Eggert:
> Can shell scripts or binfmt_misc be exploited, too? Even if not, I'd
> additionally force noexec, nosuid on proc and sysfs mounts.

Why force them, this is just papering over imagined cracks and running
from shadows. If users want to be paranoid about these file systems or
their distro vendor is smart then the ability to set noexec/nosuid is
already supported and even more can be done with selinux. In fact as its
usually mounted in one place even AppArmor might be able to get it right
8)


