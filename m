Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277485AbRJEQkO>; Fri, 5 Oct 2001 12:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277483AbRJEQkE>; Fri, 5 Oct 2001 12:40:04 -0400
Received: from foobar.isg.de ([62.96.243.63]:48000 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S277484AbRJEQjy>;
	Fri, 5 Oct 2001 12:39:54 -0400
Message-ID: <3BBDE27D.2E65F818@isg.de>
Date: Fri, 05 Oct 2001 18:40:29 +0200
From: lkv@isg.de
Organization: Innovative Software AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
In-Reply-To: <3BBDD37D.56D7B359@isg.de> <3BBDE1AA.98C4712F@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:

> > I'm currently looking for a decent method to wait on either
> > an I/O event _or_ a signal coming from another process.
> 
> > - Unix domain sockets would be awkward to use due to the fact
> >   I'd need to come up with some "filenames" for them to bind to,
> >   and both security considerations and the danger of "leaking"
> >   files that remain on disk forever make me shudder...
> 
> If you use a named socket in the abstract namespace, then it can't "leak" to
> disk....

Ok, but man 7 unix says:

 SCM_CREDENTIALS  and  the abstract namespace were introduced with
 Linux 2.2 and should not be used in portable programs

... and I really do want to write portable programs...

Regards,

Lutz Vieweg

--
 Dipl. Phys. Lutz Vieweg | email: lkv@isg.de
 Innovative Software AG  | Phone/Fax: +49-69-505030 -120/-505
 Feuerbachstrasse 26-32  | http://www.isg.de/people/lkv/
 60325 Frankfurt am Main | ^^^ PGP key available here ^^^
