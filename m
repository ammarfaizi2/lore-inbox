Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161593AbWHELGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161593AbWHELGE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161594AbWHELGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:06:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2831 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161593AbWHELGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:06:03 -0400
Date: Sat, 5 Aug 2006 13:05:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
       linux-audit@redhat.com
Subject: ELF: what should be part of the userspace headers?
Message-ID: <20060805110559.GU25692@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently a bit lost trying to understand what from the following 
headers is part of the kernel <-> userspace ABI:
include/asm/elf.h
include/linux/elfcore.h
include/linux/elf-em.h
include/linux/elf-fdpic.h
include/linux/elf.h

include/linux/elf-em.h is used by include/linux/audit.h, but this usage 
doesn't seem to be part of the kernel <-> userspace interface?

And which part of the ELF headers is part of the kernel <-> userspace 
interface?

TIA
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

