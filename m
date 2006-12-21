Return-Path: <linux-kernel-owner+w=401wt.eu-S1422947AbWLUN7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422947AbWLUN7W (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWLUN7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:59:22 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:2440 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422950AbWLUN7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:59:21 -0500
Date: Thu, 21 Dec 2006 14:59:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-Id: <20061221145922.16ee8dd7.khali@linux-fr.org>
In-Reply-To: <20061221031326.GC30299@in.ibm.com>
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221102232.5a10bece.khali@linux-fr.org>
	<m164c5pmim.fsf@ebiederm.dsl.xmission.com>
	<20061221010814.GA30299@in.ibm.com>
	<20061221141354.6d9ec3e6.khali@linux-fr.org>
	<20061221031326.GC30299@in.ibm.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Thu, 21 Dec 2006 08:43:26 +0530, Vivek Goyal wrote:
> On Thu, Dec 21, 2006 at 02:13:54PM +0100, Jean Delvare wrote:
> > On Thu, 21 Dec 2006 06:38:14 +0530, Vivek Goyal wrote:
> > > Looks like it might be a tool chain issue. I took Jean's config file and
> > > built my own kernel and I am able to boot the kernel. But I can't boot
> > > his bzImage. I observed the same behaviour as jean is experiencing. It jumps
> > > back to BIOS.
> > 
> > I can only confirm that. I installed a more recent system on the same
> > hardware, rebuilt a kernel from the same config file, and now it boots
> > OK. So it's not related to the hardware. It has to be a compilation-time
> > issue.
> 
> Looks like you have already trashed your setup. If not, is it possible to

No, of course I didn't. I installed the new system on a different hard
disk drive.

> upload the output of "objdump -D arch/i386/boot/setup.o"? This will give
> some info regarding what assembler is doing.

Here you go:
http://jdelvare.pck.nerim.net/linux/relocatable-bug/setup.asm

-- 
Jean Delvare
