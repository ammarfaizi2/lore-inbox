Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSJNHFF>; Mon, 14 Oct 2002 03:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSJNHFF>; Mon, 14 Oct 2002 03:05:05 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:60686 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261847AbSJNHFF>; Mon, 14 Oct 2002 03:05:05 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15786.28159.854350.479513@laputa.namesys.com>
Date: Mon, 14 Oct 2002 11:10:55 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Rob Landley <landley@trommello.org>
Cc: Hans Reiser <reiser@namesys.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
In-Reply-To: <200210132242.g9DMgVng334662@pimout3-ext.prodigy.net>
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com>
	<20021012012807.1BB5B635@merlin.webofficenow.com>
	<3DA7F385.3040409@namesys.com>
	<200210132242.g9DMgVng334662@pimout3-ext.prodigy.net>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Drdoom-Fodder: CERT satan root crash passwd drdoom
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley writes:
 > On Saturday 12 October 2002 06:03 am, Hans Reiser wrote:
 > > Rob Landley wrote:
 > > >I'm also looking for an "unmount --force" option that works on something
 > > >other than NFS.  Close all active filehandles (the programs using it can
 > > > just deal with EBADF or whatever), flush the buffers to disk, and
 > > > unmount.  None of this "oh I can't do that, you have a zombie process
 > > > with an open file...", I want  "guillotine this filesystem pronto,
 > > > capice?" behavior.
 > >
 > > This sounds useful.  It would be nice if umount prompted you rather than
 > > refusing.
 > 
 > The problem here is that umount(2) doesn't take a flag.  I'd be happy to have 
 > it fail unless called with the WITH_EXTREME_PREJUDICE flag or some such, but 
 > that's an API change.
 > 
 > Of course I haven't gotten that far yet, but eventually this will have to be 
 > dealt with...

There were several patches to do this. If I remember correctly Tigran
Aivazian wrote one, for example.

 > 
 > Rob

Nikita.

