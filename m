Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129382AbRBSMQC>; Mon, 19 Feb 2001 07:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129852AbRBSMPw>; Mon, 19 Feb 2001 07:15:52 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:31240 "EHLO
	babsi.intermeta.de") by vger.kernel.org with ESMTP
	id <S129382AbRBSMPr>; Mon, 19 Feb 2001 07:15:47 -0500
Date: Mon, 19 Feb 2001 13:15:42 +0100
From: "Henning P . Schmiedehausen" <hps@intermeta.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Werner Almesberger <Werner.Almesberger@epfl.ch>,
        "Henning P. Schmiedehausen" <hps@tanstaafl.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [LONG RANT] Re: Linux stifles innovation...
Message-ID: <20010219131542.D16663@forge.intermeta.de>
Reply-To: hps@intermeta.de
In-Reply-To: <20010219115314.A6724@almesberger.net> <Pine.LNX.3.96.1010219050514.17784G-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1010219050514.17784G-100000@mandrakesoft.mandrakesoft.com>; from "Jeff Garzik" on Mon, Feb 19, 2001 at 05:07:02AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 05:07:02AM -0600, Jeff Garzik wrote:
> On Mon, 19 Feb 2001, Werner Almesberger wrote:
> > Now what's at stake ? Look at the Windows world. Also there, companies
> > could release their drivers as Open Source. Quick, how many do this ?
> > Almost none. So, given the choice, most companies have defaulted to
> > closed source. Consistently complaining when a company tries to release
> > only closed source drivers for Linux seems to generally have the desired
> > effect of making them change their policy.
> 
> FWIW, -every single- Windows driver source code I've seen has been
> bloody awful.  Asking them to release that code would probably result in
> embarrassment.  Same reasoning why many companies won't release hardware
> specifications...  The internal docs are bad.  Really bad.

Because they start off bloody awful examples. From the DDK. And they
have noone to ask but M$. And they hire a student or a contract
company to write a driver after ambigous specs from the DDK.  Or they
just reiterate on a chip-vendor-supported driver again and again
(Quick, can anyone say "NVidia"?). And who certificates (hah!) a
driver written after the DDK to run on an OS? Right, the vendor of
both. =:-)

And the public documentation must be cleared by a lawyer to not
accidentially release IP of another company. And they must be reworked
by a tech writer to be readable for people that "can't go to office
#307 and ask Fred about the wiring details".

All boils down to money, IMHO, not always to bad will. Sometimes,
yes. Most of the time, the CFO will just as the project manager:
"Costs how much? Earns how much?".

I would even like think, that some HW companies would release drivers
as open source if they would be able to find individuals or contract
companies, that are willing to sign NDAs to use the inhouse
information for writing a driver without leaking the information
itself out.

I know of some companies that do that kind of contract work. 
Unfortunately most of the time for more exotic HW.

BTW: Lawyer question: 

"I release a driver as open source under, BSD license. May I put it
into the kernel source tree or must I compile it as a separate
loadable module for not being in GPL violation."

According to my understanding of the loadable module issue and the GPL
of the kernel, I must distribute the source separated from the kernel
source and may only compile as loadable module. 

Would twin licensing solve this? But then I must not pull changes from
the GPL tree back into my BSD tree and distribute this BSD tree under
BSD license, because this license allows a vendor binary only
distribution which is forbidden by the GPL'ed changes. And I must not
pose the "changes to the GPL'ed sources can be pulled back into the
BSD sources" restriction on the tree because then I am already in
violation of the GPL ("must not put additional restrictions on").

So, is it legal to put changes to a twin licensed driver in the Linux
kernel tree back into the same driver in the BSD tree?

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
