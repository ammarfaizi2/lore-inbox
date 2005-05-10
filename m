Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVEJHAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVEJHAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 03:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVEJHAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 03:00:51 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:14140 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261563AbVEJHAn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 03:00:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cp2Qb6N3V2Bk4q5hA67KxH/edBPLn9YalV3wJfecq6Oca8PeyUekz3q2NguowYa72ffziPz/RQ2UmliujeIUtBW5FaAC+WpRKY5KDczBF12HGZfKiCmKEXM3e03uEzsWBNVMhWxxSUxxazpzW4M9XvZ+pAutjOX7nKBHLqGZ9m8=
Message-ID: <2cd57c9005051000004c57050@mail.gmail.com>
Date: Tue, 10 May 2005 15:00:42 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: kexec?
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050509183428.6d7934a6.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050508202050.GB13789@charite.de>
	 <20050509183428.6d7934a6.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
> On Sun, 8 May 2005 22:20:50 +0200 Ralf Hildebrandt wrote:
> 
> | I know kexec used to be a patch, but has it gone into the mainstream
> | kernels yet?
> 
> Nope, it's only in the -mm patchset.
> Testing/reporting that could help....
 
coywolf@prodigy:~/kexec-tools-1.95/objdir/build/bin$ ./kexec_test
Segmentation fault

prodigy:/home/coywolf/kexec-tools-1.95/objdir/build/sbin# ./kexec -l
/var/local/build/vmlinux
kexec_load failed: Cannot assign requested address
entry       = (nil)
nr_segments = 2
segment[0].buf   = 0x80b4558
segment[0].bufsz = 15c
segment[0].mem   = (nil)
segment[0].memsz = 15c
segment[1].buf   = 0xb7d53008
segment[1].bufsz = 2a0086
segment[1].mem   = 0x100000
segment[1].memsz = 2c8a78

prodigy:/home/coywolf/kexec-tools-1.95/objdir/build/sbin# ./kexec -l
/var/local/build/arch/i386/boot/bzImage
kexec_load failed: Cannot assign requested address
entry       = 0x91734
nr_segments = 2
segment[0].buf   = 0x80b4480
segment[0].bufsz = 1850
segment[0].mem   = 0x90000
segment[0].memsz = 1850
segment[1].buf   = 0xb7eaa008
segment[1].bufsz = 14032d
segment[1].mem   = 0x100000
segment[1].memsz = 14032d

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
