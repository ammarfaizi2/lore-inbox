Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132582AbRA0KAg>; Sat, 27 Jan 2001 05:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbRA0KA0>; Sat, 27 Jan 2001 05:00:26 -0500
Received: from 13dyn73.delft.casema.net ([212.64.76.73]:30729 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132582AbRA0KAU>; Sat, 27 Jan 2001 05:00:20 -0500
Message-Id: <200101271000.LAA22442@cave.bitwizard.nl>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <3A70D7B2.F8C5F67C@transmeta.com> from "H. Peter Anvin" at "Jan
 25, 2001 05:49:38 pm"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Sat, 27 Jan 2001 11:00:15 +0100 (MET)
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> "David S. Miller" wrote:
> > 
> > H. Peter Anvin writes:
> >  > Last I communicated with them, I looked for a reference like that in the
> >  > standards RFCs so I could quote chapter and verse at the Hotmail people,
> >  > but I couldn't find it.
> > 
> > RFC793, where is lists the unused flag bits as "reserved".
> > That is pretty clear to me.  It just has to say that
> > they are reserved, and that is what it does.
> > 
> 
> Is the definition of "reserved" defined anywhere?  In a lot of specs,
> "reserved" means MBZ.

MBZ? Must Be Zero? 

Reserved means MBZ on things you generate, to guarantee you'll get
expected behaviour from the other side. But in no circumstance should
a reserved bit being non-zero confuse you. They should be
ignored. That leads to the "new" implementations knowing what the old
implementations will do.

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
