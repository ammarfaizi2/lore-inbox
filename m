Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRGDKlf>; Wed, 4 Jul 2001 06:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbRGDKlY>; Wed, 4 Jul 2001 06:41:24 -0400
Received: from relay2.mail.uk.psi.net ([154.32.107.6]:41958 "EHLO
	relay2.mail.uk.psi.net") by vger.kernel.org with ESMTP
	id <S262436AbRGDKlO>; Wed, 4 Jul 2001 06:41:14 -0400
Message-ID: <81E4A2BC03CED111845100104B62AFB50102A7FD@stagecoach.bts.co.uk>
From: Dave J Woolley <david.woolley@bts.co.uk>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, andrew.grover@intel.com
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, acpi@phobos.fachschaften.tu-muenchen.de
Subject: RE: [Acpi] Re: ACPI fundamental locking problems
Date: Wed, 4 Jul 2001 11:37:00 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From:	Alan Cox [SMTP:alan@lxorguk.ukuu.org.uk]
> 
> The goal isnt a technical nit, its to avoid loading 300Kbytes of crud
> (which 
> should mostly be in user space anyway) on the 99.9% of machines where we
> dont
> need it.
[DJW:]  
I argued this at the very beginning, but there was a very strong
view that you needed to run most of the code before you had a user
space to run it in.  I've not followed things closely enough to 
know whether or not this is really true and whether or not it is
inevitable, or just a flaw in the ACPI design.

My feeling has been that ACPI has violated the minimum privilege
concept from the beginning, although I think putting stuff in drivers
that could be at user level is not htat uncommon in Linux.

-- 
--------------------------- DISCLAIMER ---------------------------------
Any views expressed in this message are those of the individual sender,
except where the sender specifically states them to be the views of BTS.

>  
