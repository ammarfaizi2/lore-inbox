Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRJTW6T>; Sat, 20 Oct 2001 18:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274951AbRJTW57>; Sat, 20 Oct 2001 18:57:59 -0400
Received: from boreas.isi.edu ([128.9.160.161]:14560 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S274875AbRJTW56>;
	Sat, 20 Oct 2001 18:57:58 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jan@gondor.com (Jan Niehusmann), linux-kernel@vger.kernel.org
Subject: Re: Input on the Non-GPL Modules 
In-Reply-To: Your message of "Sat, 20 Oct 2001 23:04:11 BST."
             <E15v4Dz-0002VM-00@the-village.bc.nu> 
Date: Sat, 20 Oct 2001 15:58:18 -0700
Message-ID: <4307.1003618698@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What prevents the author of a non-GPL module who needs access to a
>> GPL-only symbol from writing a small GPLed module which imports the 
>> GPL-only symbol (this is allowed, because the small module is GPL), 
>> and exports a basically identical symbol without the GPL-only
>> restriction?
>
>The fact that it ends up GPL'd to be linked (legal derivative work sense)
>to the GPL'd code so you can link it to either but not both at the same time

	The fact is that the GPL (version 2, June 1991) does not
constrain linking so long as the linked work is not copied or
distributed (section 2).  The fact is that "The act of running the
Program is not restricted" (section 0).  Other than that, we run out
of "facts", because the whole area is untested legally, and the courts
have a fair amount of latitude.

	I believe that the following statement is true: The GPL
permits linking GPL'ed code with not-GPL-comformant code so long as
the resultant derived work is not distributed.

	I believe that the "user-does-the-link" strategy is consonent
with the text of the GPL version 2, although it might not have been
intended by the document's author(s).  I believe that individual
symbol names are not covered by copyright (although they could be
trademarked).  In my opinion (I am not a lawyer, etc.), there is no
compelling reason (other than being nice people) for non-GPL-compliant
module writers to not link against a list of "GPL-only" symbols.

	Furthermore, I suspect that using a GPL-only symbol strategy
to *restrict* runtime linking is itself PROHIBITED by GPL version 2
section 6 (the notorious "You may not impose any further restrictions
on the recipients" clause).

	Having said my piece, I refuse discuss this topic in the
immediate future on linux-kernel.  I'll be happy to converse offline
via email.

					Craig Milo Rogers
					<rogers@isi.edu>
