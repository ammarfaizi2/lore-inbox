Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132644AbRDKQol>; Wed, 11 Apr 2001 12:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbRDKQoc>; Wed, 11 Apr 2001 12:44:32 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:22020 "HELO
	zcamail03.zca.compaq.com") by vger.kernel.org with SMTP
	id <S132642AbRDKQoW>; Wed, 11 Apr 2001 12:44:22 -0400
Message-ID: <3AD489D1.D5FCCB4B@zk3.dec.com>
Date: Wed, 11 Apr 2001 12:44:01 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha "process table hang"
In-Reply-To: <20010411104040.A8773@draal.physics.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wouldn't happen to have khttpd loaded as a module, would you?  I've seen
this type of problem caused by that before...

 - Pete

Bob McElrath wrote:

> I've been experiencing a particular kind of hang for many versions
> (since 2.3.99 days, recently seen with 2.4.1, 2.4.2, and 2.4.2-ac4) on
> the alpha architecture.  The symptom is that any program that tries to
> access the process table will hang. (ps, w, top) The hang will go away
> by itself after ~10minutes - 1 hour or so.  When it hangs I run ps and
> see that it gets halfway through the process list and hangs.  The
> process that comes next in the list (after hang goes away) almost always
> has nonsensical memory numbers, like multi-gigabyte SIZE.
>
> Linux draal.physics.wisc.edu 2.3.99-pre5 #8 Sun Apr 23 16:21:48 CDT 2000
> alpha unknown
>
> Gnu C                  2.96
> Gnu make               3.78.1
> binutils               2.10.0.18
> util-linux             2.11a
> modutils               2.4.5
> e2fsprogs              1.18
> PPP                    2.3.11
> Linux C Library        2.2.1
> Dynamic linker (ldd)   2.2.1
> Procps                 2.0.7
> Net-tools              1.54
> Kbd                    0.94
> Sh-utils               2.0
> Modules Loaded         nfsd lockd sunrpc af_packet msdos fat pas2 sound
> soundcore
>
> Has anyone else seen this?  Is there a fix?
>
> -- Bob
>
> Bob McElrath (rsmcelrath@students.wisc.edu)
> Univ. of Wisconsin at Madison, Department of Physics
>
>   ------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

