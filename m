Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288205AbSANSIN>; Mon, 14 Jan 2002 13:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288246AbSANSIF>; Mon, 14 Jan 2002 13:08:05 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:42885
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288205AbSANSHx>; Mon, 14 Jan 2002 13:07:53 -0500
Date: Mon, 14 Jan 2002 12:52:28 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Eli Carter <eli.carter@inet.com>
Cc: "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114125228.B14747@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Eli Carter <eli.carter@inet.com>,
	"Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <F50839283B51D211BC300008C7A4D63F0C10759D@eukgunt002.uk.eu.ericsson.se> <20020114111141.A14332@thyrsus.com> <3C430E89.E65DCEDC@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C430E89.E65DCEDC@inet.com>; from eli.carter@inet.com on Mon, Jan 14, 2002 at 10:59:53AM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter <eli.carter@inet.com>:
> Could you maybe describe the problem you are trying to solve a bit more
> clearly than "the hardware-discovery problem for ISA devices"?  If you
> are trying to discover the ISA devices, but rely upon them having
> already been discovered, what are you accomplishing?

Sure.  Let's say Aunt Tillie needs a kernel update.

Aunt Tillie is running a distro kernel (modular everything) on the
machine her nephew Melvin bought her last year.  The distro kernel
knows about the ISA devices on the machine.

She complains of occasional lockups, and that she gets skips when
playing her Guy Lombardo MP3s.  Melvin says, over the phone: "Yup,
that version had some VM problems.  And you need the low-latency stuff
that went in three releases ago.  But never mind the technical stuff.
Just click on the 'kernel update' icon on your desktop."  Melvin is
500 miles away at college.

Aunt Tillie clicks.  She sees a message saying "Downloading kernel
sources" and a progress bar.  Under the hood, the mchine is downloading
the tip of the stable branch from a kernel.org mirror site.

So why doesn't she use Red Hat or Mandrake's RPM update?  Maybe she's
running something else.  (You ain't going to tell me Aunt Tillie is ready
for Debian apt-get, either.)  Maybe she wants a kernel that's compiled
for her AMD Athlon K6 rather than a 386.  OK, so she doesn't know what
processor she has, she just remembers that Melvin told her you get a
faster kernel when you build it yourself.

(Aunt Tillie probably thinks having a faster kernel will mean she can
download images from her favorite knitting-pattern website more
quickly.  Aunt Tillie is a little confused about the difference
between processor and network speed.  That's OK; well-designed
technology should allow people the luxury of ignorance.)

Then the progress window changes to a message that says
"Configuring..." and some information about her hardware.  This is the
autoconfigurator running inside a GUI shell.

Then it says "Building..." and another progress bar.  Finally it says
"Please enter your root password so I can install the new kernel".
And, once she's done that, it tells her "Your new kernel will be named
'Sapphire' on your boot screen.  Shall I reboot now?"  She clicks "Yes".

Her machine reboots.  She selects "Sapphire" on her boot screen.  The
new kernel boots.  She logs in.  She surfs to her knitting-pattern 
website.  She logs out.  

When she clicks "Shutdown", a popup says "This is not the same kernel
that will come up by default when you next boot.  Should I make it the
default?"  She clicks "Yes".  Her kernel upgrade is done.  It required
just four mouse clicks and one password entry.  At no point did she 
have to retain mental state about previous stages of the upgrade.
(Aunt Tillie is getting on in years; she isn't as good at retaining
abstract facts as she used to be.)

In fact, at a pinch we could have done away with the password entry,
presuming that anyone with physical access to the console is allowed
to perform canned administrative functions (though not to a root
shell).

We have the technology to do all of this now; the autoconfigurator is
the last nontrivial missing piece. And if we truly want world
domination, this is what it's going to take -- ease of use that is
Macintosh-like or better at *every* level of system use and
administration.

It takes a different way of thinking than most hackers are used to.
We're proud of our mad programming skillz and our ability to wrestle
with arcana.  That pride isn't a bad thing -- except when it gets in
the way of designing systems that Aunt Tillie can use.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Sometimes the law defends plunder and participates in it. Sometimes the law
places the whole apparatus of judges, police, prisons and gendarmes at the
service of the plunderers, and treats the victim -- when he defends himself --
as a criminal.	-- Frederic Bastiat, "The Law"
