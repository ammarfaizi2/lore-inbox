Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267788AbTBJMPX>; Mon, 10 Feb 2003 07:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267821AbTBJMPX>; Mon, 10 Feb 2003 07:15:23 -0500
Received: from tibau-e1.pop-rio.com.br ([200.239.194.250]:40644 "EHLO
	tibau.pop-rio.com.br") by vger.kernel.org with ESMTP
	id <S267788AbTBJMPU>; Mon, 10 Feb 2003 07:15:20 -0500
Date: Mon, 10 Feb 2003 10:22:34 -0200
From: Andre Costa <acosta@ar.microlink.com.br>
To: Linux kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: SCSI-IDE crash in 2.4.21pre4]
Message-Id: <20030210102234.4588ff0d.acosta@ar.microlink.com.br>
In-Reply-To: <1044847348.3767.20.camel@h68-146-142-19.localdomain>
References: <1044772315.1102.24.camel@h68-146-142-19.localdomain>
	<1044847348.3767.20.camel@h68-146-142-19.localdomain>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MailScanner: Microlink Internet Provider Anti-Virus, Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

the probls you describe ("all sorts of SCSI timeout errors, SCSI comm
errors, etc") are experienced by me and other users of KT266-based mobos
as well, under the same circumstances (cdparanoia, SCSI-emul); see
thread "kernel 2.4.x + via-based kt266 mobo = IDE cdroms probls
(revisited)" here on LKML . Maybe the probl isn't restricted to SIS735
or KT266 after all...

Best,

Andre

On 09 Feb 2003 20:22:28 -0700
Kim Lux <lux@diesel-research.com> wrote:

> One more thing: a bunch of us cdparanoia users got together and
> compared notes.  All the computers that are having the problem are
> running the SIS735 chipset.   We suspect a kernel bug in that driver.
> 
> Let me know if there is anything else we can do to help.
> 
> BTW: I think that Linux rocks !  You kernel developers/ debuggers/
> supporters do an outstanding job.  
> 
> THANKS !
> 
> Kim  
> 
> 
> 
> On Sat, 2003-02-08 at 23:31, Kim Lux wrote:
> > -----Forwarded Message-----
> > 
> > > From: Kim Lux <lux@diesel-research.com>
> > > To: linux-kernel@verger.kernel.org
> > > Subject: SCSI-IDE crash in 2.4.21pre4
> > > Date: 08 Feb 2003 23:27:23 -0700
> > > 
> > > One Line Summary:
> > > 
> > > SCSI IDE emulation crashes RH8 computer running 2.4.21 pre4.
> > > 
> > > Full Description of Problem:
> > > 
> > > I've had this problem for months.  
> > > 
> > > If I run CDParanoia and try to rip CDs, it will work OK for a few
> > > minutes and then start crashing, giving all sorts of SCSI timeout
> > > errors, SCSI comm errors, etc. (Let me know if you want these;
> > > I'll get them.)  I get the same or similar errors with KSCD as
> > > well.  This is extremely frustrating. 
> > > 
> > > I get the error with all kernels, 2.4.18-18.8.0 through 2.4.21
> > > pre-4, although 2.4.21 freezes entirely and cannot be killed,
> > > whereas all kernels prior to this allow the process to be killed. 
> > > For some reason the process survives a login and reboot with
> > > 2.4.21 pre 4, whereas it stops running with all previous kernels. 
> > > 
> > > 
> > > I've tried 2 motherboards and 2 hd cables, with the same effect. 
> > > The computer this occurs on is otherwise stable, with uptimes of
> > > several months at a time.
> > > 
> > > I might have the links/permissions messed up in /dev from trying
> > > to fix this problem. I also disabled the CD automount command in
> > > .kde/autostart.  
> > > 
> > > I've been through the CDParanoia doc several times and have tried
> > > various kernels with various SCSI-IDE config setups.  I know that
> > > ATAPI CDROM must be disabled to work with CDParanoia.  I believe
> > > I've got that set up right as CD Paranoia finds (or used to find)
> > > the CDROM player. It does rip CDs, but will crash.  I strongly
> > > believe this is a kernel problem and not a CDParanoia problem or a
> > > hardware problem. 
> > > 
> > > Keywords:
> > > 2.4.20
> > > 2.4.21-pre4
> > > SCSI-IDE Emulation
> > > CDParanoia
> > > KSCD
> > > 
> > > Kernel Version:
> > > Linux version 2.4.20 (root@h68-146-142-19) (gcc version 3.2
> > > 20020903(Red Hat Linux 8.0 3.2-7)) #2 Mon Dec 2 11:09:28 MST 2002 
> > >  
> > >  
> > > As I stated before, 2.4.21 becomes unstable on login; I cannot run
> > > it anymore as I can't kill the process.
> > > 
> > > Output of Oops: don't have it.  I got dmesg errors on boot, on
> > > /dev/hda.  See dmesg output below. 
> > > 
> > > A small shell script that triggers the problem:
> > > > CDParanoia -svB or run KSCD.
> > > 
> > > Environment: (see below) Running KDE.  Everything stable
> > > otherwise. 

-- 
Andre Oliveira da Costa
