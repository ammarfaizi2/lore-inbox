Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318725AbSICQEp>; Tue, 3 Sep 2002 12:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSICQEo>; Tue, 3 Sep 2002 12:04:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51977 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318725AbSICQD7>; Tue, 3 Sep 2002 12:03:59 -0400
Date: Tue, 3 Sep 2002 13:08:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <200209031604.g83G4fY06284@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44L.0209031307430.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> "A month of sundays ago Maciej W. Rozycki wrote:"
> > On Tue, 3 Sep 2002, Rik van Riel wrote:
> > > And what if they both allocate the same disk block to another
> > > file, simultaneously ?
> >
> >  You need a mutex then.  For SCSI devices a reservation is the way to go
> > -- the RESERVE/RELEASE commands are mandatory for direct-access devices,
> > so thy should work universally for disks.
>
> Is there provision in VFS for this operation?

No. Everybody but you seems to agree these things should be
filesystem specific and not in the VFS.

> (i.e. care to point me at an entry point? I just grepped for "reserve"
> and came up with nothing useful).

Good.

cheers,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

