Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312453AbSDDRGf>; Thu, 4 Apr 2002 12:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313267AbSDDRGQ>; Thu, 4 Apr 2002 12:06:16 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:36034 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S312453AbSDDRGM>;
	Thu, 4 Apr 2002 12:06:12 -0500
Message-Id: <5.1.0.14.2.20020404180430.01f6cec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 04 Apr 2002 18:06:03 +0100
To: Ingo Molnar <mingo@redhat.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Cc: Rik van Riel <riel@conectiva.com.br>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204041123410.6422-100000@devserv.devel.redh
 at.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:29 04/04/02, Ingo Molnar wrote:

>On Thu, 4 Apr 2002, Anton Altaparmakov wrote:
>
> > Both or these aren't really practical once you think it through. Don't
> > forget that each binary module can be wrapped by an GPL-module which the
> > kernel cannot do anything at all about and the kernel would never even
> > know a binary only module was loaded because the GPL module does it.
> > There is no such thing as security... This kind of thing is already in
> > use by at least two companies I know of (i.e. using open sourced glue
> > modules to binary only code) so it is not just a theory I am making
> > up...
>
>there are countries where this might be considered a 'circumvention of a
>technological measure' that controls access to a work. Law enforcement is
>not the duty of the copyright holders. There is no such thing as a
>burglar-safe house either.

I guess so. Sorry, IANAL and I live in a relatively free country so I 
forgot about that place over the pond... (-:

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

