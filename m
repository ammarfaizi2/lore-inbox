Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264026AbSIVJu5>; Sun, 22 Sep 2002 05:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264034AbSIVJu4>; Sun, 22 Sep 2002 05:50:56 -0400
Received: from 62-190-218-154.pdu.pipex.net ([62.190.218.154]:7684 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S264026AbSIVJuj>; Sun, 22 Sep 2002 05:50:39 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209221003.g8MA3kGc000201@darkstar.example.net>
Subject: Re: Kernel Issues
To: praduddao@hotmail.com (walairat kladmuk)
Date: Sun, 22 Sep 2002 11:03:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F138D7O5CkJNQNXSqVd00002250@hotmail.com> from "walairat kladmuk" at Sep 22, 2002 09:42:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a problem installing Mandrake 8.2.
> 
> Installation appears to work fine but when I try and boot the system the 
> following is a copy of the kernel messages as boot fails (last 8 lines)
> 
> PCI <something>
> PCI <something>
> PCI <something>
> PCI <something>
> Isapnp: Scanning for PnP Cards
> CPU0: Machine Check Exception: 00000000000000000007
> Bank 3: b40000000000000000000083b at 0000000000000001fc0003b3
> Kernel Panic: Unable to continue
> 
> Having played around with numerous installation techniques (full/min, 
> various partition configs/types) over the last 4 days I haven't made any 
> progress.
> 
> I even tried Red Hat 7.3 (Valhalla) and the same happened.

Try downloading this boot disk image from ftp.slackware.com, (or a mirror):

/pub/slackware/slackware-current/bootdisks/bare.i

write it to a disk, and boot from it.

Let us know whether it gets to the point where it asks you for the next disk or not.  If the kernel panics before that point, there is definitely something wrong.

If it does panic before asking for the next disk, you could try the lowmem.i boot disk in the same directory, and let us know whether that boots as well.

John.
