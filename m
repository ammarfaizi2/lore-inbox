Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbQJ0R5n>; Fri, 27 Oct 2000 13:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129985AbQJ0R5d>; Fri, 27 Oct 2000 13:57:33 -0400
Received: from ra.lineo.com ([207.179.37.37]:57269 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129904AbQJ0R5X>;
	Fri, 27 Oct 2000 13:57:23 -0400
Message-ID: <39F9C191.BCFA0E16@Rikers.org>
Date: Fri, 27 Oct 2000 11:55:29 -0600
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu detection fixes for test10-pre4
In-Reply-To: <E13pANf-0004Va-00@the-village.bc.nu>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 10/27/2000
 11:57:22 AM,
	Serialize complete at 10/27/2000 11:57:22 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > >   - make Pentium IV and other post-P6 processors use the "i686"
> > >     family name (same fix as the system_utsname.machine init fix
> > >     which went into include/asm-i386/bugs.h in test10-pre4)
> > >
> >
> > We should never have used anything but "i386" as the utsname... sigh.
> 
> Its questionable if we should include the 'i'

heh, agreed. let's rename 'em all x86 and be done with it. ;-)

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
