Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTFXXXo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTFXXXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:23:42 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:32524 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S264030AbTFXXXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:23:08 -0400
From: vanstadentenbrink@ahcfaust.nl
To: linux-kernel@vger.kernel.org
Date: Wed, 25 Jun 2003 01:37:19 +0200
MIME-Version: 1.0
Subject: RE: GPL violations by wireless manufacturers
Message-ID: <3EF8FCCF.22977.F28524@localhost>
In-reply-to: <MDEHLPKNGKAHNMBLJOLKGEGBDOAA.davids@webmaster.com>
References: <3EF85024.4477.78EB14@localhost>
X-mailer: Pegasus Mail for Windows (v4.11)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC replies as I am not subscribed ]

In reply to DS:

A final attempt to convince you; after that it is back to the paid 
legal work for me :).

When you load a non-gpl kernel module (like that kernel driver module 
on the router) you 'taint the kernel', as it is called. After doing 
so, the running kernel is a 'modified program' under the gpl. 
Distributing a modified program 'as a whole' gpls (is that a verb?) 
the combination as a whole.

Under the gpl you are however allowed to distribute the gpl kernel 
and the non-gpl module separately, like NVidia does with their non-
gpl kernel modules. Distribution on separate volumes would also be 
allowed (mere aggregation).

How do you distribute the two separately? My opinion is: definitely 
not by making the driver module load itself automatically, thereby 
tainting the kernel automatically, with no option for removal of the 
module, like the wireless router does. You have to provide the user 
an option to load or at least unload the module at will.
 
So how would you distribute a non-gpl module separately in a wireless 
router? I honestly don't know. Fact of the matter is that in my 
opinion it is quite scary to use a GPL'ed OS on an embedded system if 
you want to keep your modules a secret. It is a 'viroid'-license as 
Bill G. calls it, because of its license-infecting capabilities.

Regarding the "work based on" = "derived" issue: unfortunately I can 
tell you a lot about Dutch and European Law, but I know too little 
about American law to judge on that.

Regards,


Richard.

On 24 Jun 2003 at 11:18, David Schwartz wrote:

> > In response to DS:
> 
> > > So is a Linux distribution "a whole which is a work based on 
the" Linux
> > > kernel? Would you argue that RedHat can't include proprietary
> > > software on
> > > the same CD as the Linux kernel? All the software on the CD,
> > > assuming it's
> > > Linux software, likewise extends the kernel through a
> > > well-defined boundary.
> 
> > No, definitely not. If that were the case, SuSE and Lindows etc. 
etc.
> > would not be able to distribute proprietary software together 
with
> > GPL'ed software. The GPL calls this 'mere aggregation':
> 
> > "In addition, mere aggregation of another work not based on the
> > Program with the Program (or with a work based on the Program) on 
a
> > volume of a storage or distribution medium does not bring the 
other
> > work under the scope of this License."
> 
> 	But they're not just on the same CD. The additional work extends 
the Linux
> kernel and is useless without it (or without something that 
emulates it).
> 
> > These wireless products are different. The user doesn't have a 
choice
> > to use or not to use the non-gpl'ed kernel module.
> 
> 	So any software a Linux distribution installs by default has to be 
GPL?
> 
> > He can not prevent
> > the module from loading, he can not remove it from the running 
kernel
> > and the device doesn't operate without the module.
> 
> 	That the device doesn't operate without the module says nothing 
about the
> relationship between the linux kernel and the module. That they 
provide no
> interface to unload the module doesn't change the fact that there's 
a
> boundary between the kernel and the module that keeps them separate 
works.
> 
> > The module and the
> > embedded Linux OS on the device are so interconnected that they 
can
> > not be considered 'seperate works' under the GPL. Therefore the
> > kernel module actually is GPL software itself.
> 
> 	Obviously, I don't agree. The linux kernel is totally usable 
without the
> module. The module only extends the kernel through a standardized 
interface.
> This is sufficient, in my book, to make them separate works. That 
they are
> shipped on the same medium and that the user can't separate them is
> irrelevent -- you can't separate them if they're shipped on the 
same CD
> anyway without a scalpel.
> 
> 	The GPL can't declare a legal fiction and thereby make it into a 
fact. I
> would think it's quite probable that a court would interpret the 
GPL's "work
> based on" concept to be equivalent to the legal concept of a 
derived work.
> Otherwise, the GPL can't restrict its distribution (a copyright 
holder has
> the right to control the distribution of derived works but not 
works that
> aren't derived, even if they meet the license's definition of 
'based on').
> 
> > Buffalo Technology's response indicates that they agree with me 
(or
> > perhaps they just don't want any trouble).
> 
> 	Perhaps they just prefer to release the module under the GPL.
> 
> 	DS
> 
> 



