Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136480AbRD3IDB>; Mon, 30 Apr 2001 04:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136481AbRD3ICm>; Mon, 30 Apr 2001 04:02:42 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:46346 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136480AbRD3IC2>;
	Mon, 30 Apr 2001 04:02:28 -0400
Date: Mon, 30 Apr 2001 04:03:04 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: John Stoffel <stoffel@casc.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
Message-ID: <20010430040304.A5839@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	John Stoffel <stoffel@casc.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <5.0.2.1.2.20010430023154.03cd52b0@pop.cus.cam.ac.uk> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <5.0.2.1.2.20010430023154.03cd52b0@pop.cus.cam.ac.uk> <20010429214136.A2260@thyrsus.com> <5.0.2.1.2.20010430085034.00b0d3b0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010430085034.00b0d3b0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Mon, Apr 30, 2001 at 08:52:34AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk>:
> >I tried whitespace, but the default Tkinter font isn't fixed-width.  How
> >do you do invisible text?
> 
> Text colour = background colour -> invisible

Well, duh.  Unfortunately, it doesn't seem to have occured to the dozen or
so people who suggested this that:

(a) Background color can vary depending on how Tk's X resources are set, and

(b) Tk doesn't give me, AFAIK, any way to query either that background color
    or those resources.

Fer cripes' sake.  If it were that easy I'd have *done* it already, people!

Anyway my attempts to set a foreground color on an inactive button widget 
failed.  I don't know why.  Tk is full of weird little corners like that.

What I've done is just disabled inactive help buttons without trying to
hack the text or color. That makes them all the same width, though the 
legend "Help" does show up in gray on the inacive ones.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The state calls its own violence `law', but that of the individual `crime'"
	-- Max Stirner
