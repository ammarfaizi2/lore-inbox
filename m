Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRKMTWc>; Tue, 13 Nov 2001 14:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278313AbRKMTWW>; Tue, 13 Nov 2001 14:22:22 -0500
Received: from mail201.mail.bellsouth.net ([205.152.58.141]:39023 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278549AbRKMTWJ>; Tue, 13 Nov 2001 14:22:09 -0500
Message-ID: <3BF172CC.8E013C7F@mandrakesoft.com>
Date: Tue, 13 Nov 2001 14:21:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
In-Reply-To: <20011112232539.A14409@redhat.com> <20011113121022.L1778@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Nov 12, 2001  23:25 -0500, Benjamin LaHaise wrote:
> > Please incorporate this patch to make mtrr.c conform to the standards set
> > forth in Documentation/CodingStyle which make it much more appealing to
> > the eyes.
> >
> >  /*  Put the processor into a state where MTRRs can be safely set  */
> > -static void set_mtrr_prepare (struct set_mtrr_context *ctxt)
> > +static void
> > +set_mtrr_prepare(struct set_mtrr_context *ctxt)
> >  {
> 
> Is that actually CodingStyle?  Don't see it much in the kernel code...

IMHO CodingStyle is defined in theory by Documentation/CodingStyle, and
in practice by linux/scripts/Lindent, which was changed in 2.4.15-preXX
even, to be more up-to-date.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

