Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262550AbRF1Sx0>; Thu, 28 Jun 2001 14:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbRF1SxQ>; Thu, 28 Jun 2001 14:53:16 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28803 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262550AbRF1SxE>;
	Thu, 28 Jun 2001 14:53:04 -0400
Message-ID: <3B3B7D34.FFA71114@mandrakesoft.com>
Date: Thu, 28 Jun 2001 14:53:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <Pine.LNX.4.33.0106281040000.10308-100000@localhost.localdomain> <Pine.LNX.4.33.0106281057170.15199-100000@penguin.transmeta.com> <20010628131641.5e10ecca.reynolds@redhat.com> <9hfter$9e7$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> In article <20010628131641.5e10ecca.reynolds@redhat.com>,
> Tommy Reynolds  <reynolds@redhat.com> wrote:
> >Linus Torvalds <torvalds@transmeta.com> was pleased to say:
> >
> >> If they are shut off, then where's the drumming? Because if people start
> >> making copyright printk's normal, I will make "quiet" the default.
> >
> >Amen.  This is like editing a program to remove the "harmless" compiler warning
> >messages.  If I don't get a useless message, I don't have to decide to ignore
> >it.  Describing what's happening is OK; don't gush.
> 
> Yep - a driver should print out that it loaded and what hardware it
> found. Nothing else.
> 
> You know what I hate? Debugging stuff like BIOS-e820, zone messages,
> dentry|buffer|page-cache hash table entries, CPU: Before vendor init,
> CPU: After vendor init, etc etc, PCI: Probing PCI hardware,
> ip_conntrack (256 buckets, 2048 max), the complete APIC tables, etc
> 
> That's stuff that noone cares about. If the system fails to boot
> boot it with a debug flag. If it does boot, _fine_.

Actually this [IMHO] a bug that should be fixed in 2.4:  The default
logging level for the production 2.4 kernel includes KERN_DEBUG, which
is why you see a lot of this crap.

> arch/i386/kernel/setup.c:       printk(KERN_DEBUG "CPU:             Common caps: %08x %08x %08x %08x\n",

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
