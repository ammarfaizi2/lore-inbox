Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135220AbRDRSpv>; Wed, 18 Apr 2001 14:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135223AbRDRSpm>; Wed, 18 Apr 2001 14:45:42 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29608 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135220AbRDRSpZ>;
	Wed, 18 Apr 2001 14:45:25 -0400
Message-ID: <3ADDE0C0.BD5B0EF5@mandrakesoft.com>
Date: Wed, 18 Apr 2001 14:45:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Simon Richter'" 
	<Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9A@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> 
> > From: Simon Richter
> > > We are going to need some software that handles button
> > events, as well as
> > > thermal events, battery events, polling the battery, AC
> > adapter status
> > > changes, sleeping the system, and more.
> >
> > Yes, that will be a separate daemon that will also get the
> > events. But I
> > think it's a good idea to have a simple interface that allows
> > the user to
> > run arbitrary commands when ACPI events occur, even without
> > acpid running
> > (think of singleuser mode, embedded systems, ...).
> 
> Fair enough. I don't think I would be out of line to say that our resources
> are focused on enabling full ACPI functionality for Linux, including a
> full-featured PM policy daemon. That said, I don't think there's anything
> precluding the use of another daemon (or whatever) from using the ACPI
> driver's interface.

There's a ton of stuff to focus on :)

For example, if you focused on suspend and resume, I could start
implementing and testing that in the drivers :)

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
