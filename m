Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQKLAS4>; Sat, 11 Nov 2000 19:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQKLASq>; Sat, 11 Nov 2000 19:18:46 -0500
Received: from slc644.modem.xmission.com ([166.70.7.136]:36871 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129121AbQKLAS3>; Sat, 11 Nov 2000 19:18:29 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001109113524.C14133@animx.eu.org> <m1g0kycm0x.fsf@frodo.biederman.org> <8ukaeb$eh6$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2000 17:09:10 -0700
In-Reply-To: "H. Peter Anvin"'s message of "11 Nov 2000 12:33:15 -0800"
Message-ID: <m13dgycaqh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <m1g0kycm0x.fsf@frodo.biederman.org>
> By author:    ebiederm@xmission.com (Eric W. Biederman)
> In newsgroup: linux.dev.kernel
> > > > 
> > > > The interface is designed to be simple and inflexible yet very
> > > > powerful.  To that end the code just takes an elf binary, and a
> > > > command line.  The started image also takes an environment generated
> > > > by the kernel of all of the unprobeable hardware details.
> > > 
> > > Isn't this what milo does on alpha?
> > 
> > Similar milo uses kernel drivers in it's own framework.  
> > This has proved to be a major maintenance problem.  Milo is nearly
> > a kernel fork.  
> > 
> > The design is for the long term to get this incorporated into the
> > kernel, and even if not a small kernel patch should be easier to
> > maintain that a harness for calling kernel drivers.
> > 
> 
> I'm working on something similiar in "Genesis".  It pretty much is (or
> rather, will be) a kernel *port*, not a fork; the port is such that it
> can run on top of a simple BIOS extender and thus access the boot
> media.

Hmm.  You must mean similiar to milo.

Have fun.  With linuxBIOS I'm working exactly the other way.  Killing
off the BIOS.  And letting the initial firmware be just a boot loader.
The reduction is complexity should make it more reliable.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
