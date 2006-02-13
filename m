Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWBMKrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWBMKrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWBMKrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:47:07 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:29615 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932077AbWBMKrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:47:06 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 11:45:32 +0100
To: tytso@mit.edu, schilling@fokus.fraunhofer.de
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0634C.nailKUS6JSGJH@burner>
References: <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org>
 <43ECA934.nailJHD2NPUCH@burner> <20060210155711.GA11566@thunk.org>
In-Reply-To: <20060210155711.GA11566@thunk.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Fri, Feb 10, 2006 at 03:54:44PM +0100, Joerg Schilling wrote:
> > >
> > > 1)  File != device.
> > 
> > I am sorry, but it turns out that you did not understand the problem.
> > 
> > Try to inform yourself about the relevence (and content) of st_dev before
> > replying again.
>
> st_dev is irrelevant in the context of CD burning.

If you did try to understand the reason why I did introduce the POSIX
claim, you would know that if Linux did try to follow the POSIX rule,
a side effect would be that removable devices need to have a stable 
mapping in the kernel


> In the context of mounted files, the only guarantee given by POSIX is
> that st_dev and st_ino for a particular file is unique.  But that
> clearly is true while the containing filesystem is mounted.  Even with
> Solaris, if a particular removable filesystem is unmounted and removed
> from one device (say one Jazz/Zip drive) and inserted into another
> device (say another Jazz/Zip drive), st_dev will change --- while the
> system is running.

Please don't confuse the fact that you will _always_ be able to find
ways to confuse a system with the fact that this needs to happen in all cases.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
