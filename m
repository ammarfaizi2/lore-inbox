Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbREKOkH>; Fri, 11 May 2001 10:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbREKOj5>; Fri, 11 May 2001 10:39:57 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19085 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131191AbREKOjt>;
	Fri, 11 May 2001 10:39:49 -0400
Message-ID: <3AFBF9B4.E05EADA7@mandrakesoft.com>
Date: Fri, 11 May 2001 10:39:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mauelshagen@sistina.com
Cc: linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
In-Reply-To: <20010511162745.B18341@sistina.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Heinz J. Mauelshagen" wrote:
> In order to avoid this difference we provide smaller patches more often now.
> We have started already with a subset of about 50 necessary patches.
> 
> Even though we get kind support from Alan Cox to get those QAed and integrated,
> the pure amount of patches will take at least a couple of weeks to make it in.

Are you sending them all in one batch (50 e-mails to Linus at once), or
trickling them to Linus a few at a time?  It might be faster to send him
a batch (though not necessarily 50), noting with each e-mail, after each
patch's description, that the particular patch depends patches C, F, and
H that have come before it.  That way Linus can apply 8 out of 10
patches, and then you synchronize with him and start the cycle over
again.


> In regard to this situation we'ld like to know about your oppinion on
> the following request:
> is it acceptable to release 1.0 soon *before* all patches to reach the 1.0 code
> status are in vanilla (presumed that we provide them with our release as we
> always did before)?

Subsystems are often maintained outside the Linus tree, with code
getting pushed (hopefully regularly) to Linus.  For such scenarios, it
should be no problem to release software before all of it passes Linus. 
You are the one who has to deal with user support after all :)   Just
make sure that all fixes and changes currently in the kernel are also in
your software release...

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
