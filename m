Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132668AbRA0KUf>; Sat, 27 Jan 2001 05:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRA0KUZ>; Sat, 27 Jan 2001 05:20:25 -0500
Received: from 13dyn73.delft.casema.net ([212.64.76.73]:32777 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132668AbRA0KUM>; Sat, 27 Jan 2001 05:20:12 -0500
Message-Id: <200101271020.LAA22568@cave.bitwizard.nl>
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <94q96s$9b2$1@cesium.transmeta.com> from "H. Peter Anvin" at "Jan
 25, 2001 02:26:36 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 27 Jan 2001 11:20:04 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <3A709E99.25ADE5F6@echostar.com>
> By author:    "Ian S. Nelson" <ian.nelson@echostar.com>
> In newsgroup: linux.dev.kernel
> >
> > I'm curious.  Why does Linux make that friendly 98/9a/88 looking
> > postcode pattern when it's running?  DOS and DOS95 don't do that.
> > 
> > I'm begining to feel like I can tell the system health by observing it,
> > kind of like "seeing the matrix."
 
> It output garbage to the 80h port in order to enforce I/O delays.
> It's one of the safe ports to issue outs to.

Yes, because it is reserved for POST codes. You can get "POST
debugging cards" that simply have a BIN -> 7segement encoder and two 7
segment displays on them. They decode 0x80. That's what it's for. 

Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
