Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <157336-17165>; Sun, 6 Dec 1998 07:24:33 -0500
Received: from 3dyn10.delft.casema.net ([195.96.104.10]:4180 "EHLO rosie.BitWizard.nl" ident: "root") by vger.rutgers.edu with ESMTP id <157102-17165>; Sun, 6 Dec 1998 02:41:04 -0500
Message-Id: <199812061016.LAA00459@cave.bitwizard.nl>
Subject: Re: atomicity
In-Reply-To: <m0zmNHr-0007U1C@the-village.bc.nu> from Alan Cox at "Dec 5, 98 07:22:38 pm"
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 6 Dec 1998 11:16:24 +0100 (MET)
Cc: feuer@his.com, linux-kernel@vger.rutgers.edu
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Alan Cox wrote:
> Think about it this way. SIGKILL and a power failure are identical.

Well, I occasionally get processes stuck in "D" state. SIGKILL doesn't
kill them, a power failure does. (Try a filesystem that Oops-es on the
"mount" system call, then retry the mount). 

Yeah, I know I've taken your quote out of context. Sorry. :-)

				Roger. 

-- 
My pet light bulb is a year old today.   \_________  R.E.Wolff@BitWizard.nl
That's 5.9*10^12 miles. Your mileage will NOT vary.\__Phone: +31-15-2137555
--(time <-> distance can be converted: lightspeed)--  \____ fax: ..-2138217
We write Linux device drivers for any device you may have! \_______________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
