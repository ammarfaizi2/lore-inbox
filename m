Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbQLHSOU>; Fri, 8 Dec 2000 13:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbQLHSOK>; Fri, 8 Dec 2000 13:14:10 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36369 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129842AbQLHSOB>;
	Fri, 8 Dec 2000 13:14:01 -0500
Message-ID: <3A311D95.A39E0241@mandrakesoft.com>
Date: Fri, 08 Dec 2000 12:42:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
In-Reply-To: <3A3066EC.3B657570@timpanogas.org> <E144O4d-0003vd-00@the-village.bc.nu> <20001208113340.B4730@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> On Fri, Dec 08, 2000 at 02:00:29PM +0000, Alan Cox wrote:
> > > Agree.  We need to disable it, since folks do not read the docs
> > > (obviously).  Of course, we could leave it on, and I could start
> > > charging money for these tools -- there's little doubt it would be a
> > > lucrative business.  Perhaps this is what I'll do if the numbers of
> > > copies keeps growing.  When it hits > 100 per week, it's taking a lot of
> > > our time to support, so I will have to start charging for it.
> >
> > I am very firmly against removing something because people do not read manuals,
> > what is next fdisk , mkfs ?.
> 
> We should put in a nastier message then.  It WILL DESTROY DATA IRREPARABLY
> and I've got even more bad news -- because it's in Linux, Microsoft is already
> altering the on-disk structures again, so it's about to be broken in R/O
> mode as well when Whistler comes out.

We don't need any messages.  If (DANGEROUS) is not sufficient, then
disable the feature unconditionally.  Someone hacking on the code will
be smart enough to enable the stuff while they are debugging.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
