Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRI3RGb>; Sun, 30 Sep 2001 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273801AbRI3RGV>; Sun, 30 Sep 2001 13:06:21 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:50360 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S273796AbRI3RGL>; Sun, 30 Sep 2001 13:06:11 -0400
Date: Sun, 30 Sep 2001 10:08:00 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Ookhoi <ookhoi@dds.nl>
cc: Chris Meadors <clubneon@hereintown.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: boot/root floppies in modern times?
In-Reply-To: <20010930185017.H9327@humilis>
Message-ID: <Pine.LNX.4.33.0109300959010.23874-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a number of new laptops have pci ethernet interfaces on mini-pci cards...
on both an hp omnibook 500 (3com 9xx), and a thinkpad x20 (intel) I've
done a network install of redhat 7.1 using the single bootnet floppy.

regards
joelja

 On Sun, 30 Sep 2001, Ookhoi wrote:

> Hi Chris,
>
> > I got a new Thinkpad, it doesn't have an internal floppy drive.  Instead
> > it has a USB floppy.  It can boot from the floppy just fine, I can get my
> > custom boot disk's kernel loaded.  But when it comes to loading the root
> > image I run into trouble.
>
> I had the same problem with my vaio c1ve. Only a usb floppy drive, and
> no way to let it read the second floppy disk or to make it mount root
> via nfs as the nic got active after the bootp requests.
>
> I solved this by using one floppy with a initrd with enough tools to
> download the drivers which were not in the kernel (for example usb &
> scsi, or ide). You then just download the modules plus insmod on your
> ramdisk and of you go.
>
> Hope this helps!
>
> 	Ookhoi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


