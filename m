Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbRFEN1K>; Tue, 5 Jun 2001 09:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263976AbRFEN1A>; Tue, 5 Jun 2001 09:27:00 -0400
Received: from lotus.ariel.com ([204.249.107.2]:14049 "EHLO cranmail.ariel.com")
	by vger.kernel.org with ESMTP id <S263975AbRFEN06>;
	Tue, 5 Jun 2001 09:26:58 -0400
From: "Arthur Naseef" <arthur.naseef@ariel.com>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Exporting new functions from kernel 2.2.14 
Date: Tue, 5 Jun 2001 09:25:55 -0400
Message-ID: <OIBBKHIAILDFLNOGGFMNIEHMCBAA.arthur.naseef@ariel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <16891.991747473@ocs3.ocs-net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for being so helpful. Indeed!

> -----Original Message-----
> From: Keith Owens [mailto:kaos@ocs.com.au]
> Sent: Tuesday, June 05, 2001 9:25 AM
> To: Arthur Naseef
> Cc: Linux Kernel
> Subject: Re: Exporting new functions from kernel 2.2.14 
> 
> 
> On Tue, 5 Jun 2001 09:10:56 -0400, 
> "Arthur Naseef" <arthur.naseef@ariel.com> wrote:
> >I still have not figured out the magic that creates the .ver files which
> >would resolve your concern with the symbol versions, but I do know that
> >you can edit the .ver file yourself (under /usr/src/linux/include/modules/)
> >and add entries.  This will eliminate the funny versioning, as in:
> >
> >    grab_timer_interrupt_R__ver_grab_timer_interrupt
> >
> >You can pick a hash value to use.  For example, you might add the following:
> >
> >	#define __ver_grab_timer_interrupt	a1b2c3d4
> >	#define grab_timer_interrupt	_set_ver(grab_timer_interrupt)
> 
> Remind me _NEVER_ to answer any of your module problems.  Make up your
> own hash indeed, complete and utter rubbish!
