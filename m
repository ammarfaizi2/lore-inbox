Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280600AbRKUJ2w>; Wed, 21 Nov 2001 04:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281441AbRKUJ2m>; Wed, 21 Nov 2001 04:28:42 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:56591 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S280600AbRKUJ2b>; Wed, 21 Nov 2001 04:28:31 -0500
Message-ID: <3BFB7381.A0BB2474@idb.hist.no>
Date: Wed, 21 Nov 2001 10:27:29 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Dale Amon <amon@vnl.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
In-Reply-To: <20011120190316.H19738@vnl.com> <2048.1006291657@redhat.com> <20011120214705.D22590@vnl.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale Amon wrote:
> 
> On Tue, Nov 20, 2001 at 09:27:37PM +0000, David Woodhouse wrote:
> > Why must the motherboard be set to eth0? Why not just configure it as it
> > gets detected?
> 
> There are a couple reasons. One that is specific to this
> particular case is that the VeryExpensiveProprietaryPackage
> someone bought checks the eth0 MAC address to be sure you
> haven't moved it. It would not really be smart to license
> it against a removable, swappable PCI card.
> 
Such a licencing scheme isn't very smart on a os where
the kernel source is available anyway.

It is trivial for a programmer to change what MAC address
(or _anything else_ the os reports about hardware,
simply by altering the system call.  There happens
to be tools for changing the MAC address, but 
event that isn't necessary - anything can be worked
around in the source.  So, a criminal can run
such a package on any number of machines because they
may all appear to have the same MAC address to the
checking program.  I have heard of people writing
emulators for parallell port dongles too.

Of course most people obey the law, but some still need
such tricks so they can work around broken licencing
schemes that prevent _legal_ use, and avoid dongles
that mess up communication with newer devices.

Helge Hafting
