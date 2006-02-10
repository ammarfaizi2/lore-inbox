Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWBKDZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWBKDZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 22:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWBKDZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 22:25:47 -0500
Received: from smtp.enter.net ([216.193.128.24]:44044 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932134AbWBKDZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 22:25:46 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Thu, 9 Feb 2006 22:21:56 -0500
User-Agent: KMail/1.8.1
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <200602090757.13767.dhazelton@enter.net> <43EC8F22.nailISDL17DJF@burner>
In-Reply-To: <43EC8F22.nailISDL17DJF@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602092221.56942.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 08:03, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > And does cdrecord even need libscg anymore? From having actually gone
> > through your code, Joerg, I can tell you that it does serve a larger
> > purpose. But at this point I have to ask - besides cdrecord and a few
> > other _COMPACT_ _DISC_ writing programs, does _ANYONE_ use libscg? Is it
> > ever used to access any other devices that are either SCSI or use a SCSI
> > command protocol (like ATAPI)?  My point there is that you have a
> > wonderful library, but despite your wishes, there is no proof that it is
> > ever used for anything except writing/ripping CD's.
>
> Name a single program (not using libscg) that implements user space SCSI
> and runs on as many platforms as cdrecord/libscg does.

I'm not the maintainer of a program, and hence I don't have to.

But why in the hell do you even _need_ SCSI in userspace when the kernel 
provides complete facilities? And even then your argument is specious, since 
when I did go through the code for libscg all it provided was a simple 
wrapper around those kernel facilities for as many OS's as had them. And for 
the OS's that didn't have it, then you implemented what you could. You really 
need to stop with the finger pointing and accept that you have a problem in 
your philosophy.

DRH
