Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288930AbSBKMRz>; Mon, 11 Feb 2002 07:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSBKMRq>; Mon, 11 Feb 2002 07:17:46 -0500
Received: from dialin-145-254-129-082.arcor-ip.net ([145.254.129.82]:8196 "EHLO
	dale.home") by vger.kernel.org with ESMTP id <S288930AbSBKMRc>;
	Mon, 11 Feb 2002 07:17:32 -0500
Date: Mon, 11 Feb 2002 13:17:13 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020211131713.A8614@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020211085140.B27189@namesys.com> <Pine.LNX.4.44.0202111247270.21009-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202111247270.21009-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 12:52:27PM +0100, Luigi Genoni wrote:
> I got the same with 2.5.4-pre1 on a  ATA66 disk,
> chipset i810, PentiumIII with 256 MBRAM,
> and then on Athlon 1300 Mhz, scsi disk, adaptec
> 2940UW, 512MB RAM.
> 
> I saw then just after a reboot.
> Those file has been opened three or four days before the reboot expect of
> .history.
> I got no messages, and, that is the most interesting thing, this
> corruption was just for text file. I also edited some binary file with
> kexedit and them have not been corrupted after the reboot.
was the edited file all the time on reiserfs? I mean, maybe kexedit
uses temporary file on some other fs?


> 
> reiserfsck does not show any corruption, and the HW is good.
> I know it is just a "me too", but i can do every test you need on the
> PentiumIII
Oleg, i may have to give you another set of apologies :) The fs problems
the reiserfsck have found could well be from the old kernels (although
the box crashes very rarely, just because the longest uptime is about 3
hours).


> 
> Luigi Genoni
> 
> On Mon, 11 Feb 2002, Oleg Drokin wrote:
> 
> > Hello!
> >
> > On Fri, Feb 08, 2002 at 11:07:13PM +0100, Alex Riesen wrote:
> >
> > > hmm.. You're demanding too much(mkreiserfs) - it's my home partition :)
> > At least reiserfsck before any tests is almost mandratory ;)
> >
> > > Maybe the corruptions are from previous kernels, but the zero-files
> > > are observed for the first time, particularly in the .bash_history.
> > Yes, but you said with the patch you cannot reproduce zero files anymore.
> >
> > > Sorry for such a dirty test environment, i was really not prepared.
> > > Logs attached.
> > I am sorry, but there are so many variables, these logs are barely useful as
> > of now.
> > If you can reproduce on a clean filesystem with not faulty hardware, that
> > would be interesting, though.
...
