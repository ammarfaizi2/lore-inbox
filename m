Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWBJP5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWBJP5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWBJP5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:57:19 -0500
Received: from thunk.org ([69.25.196.29]:12014 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932147AbWBJP5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:57:19 -0500
Date: Fri, 10 Feb 2006 10:57:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210155711.GA11566@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
	jengelh@linux01.gwdg.de
References: <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org> <43ECA934.nailJHD2NPUCH@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ECA934.nailJHD2NPUCH@burner>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 03:54:44PM +0100, Joerg Schilling wrote:
> >
> > 1)  File != device.
> 
> I am sorry, but it turns out that you did not understand the problem.
> 
> Try to inform yourself about the relevence (and content) of st_dev before
> replying again.

st_dev is irrelevant in the context of CD burning.

In the context of mounted files, the only guarantee given by POSIX is
that st_dev and st_ino for a particular file is unique.  But that
clearly is true while the containing filesystem is mounted.  Even with
Solaris, if a particular removable filesystem is unmounted and removed
from one device (say one Jazz/Zip drive) and inserted into another
device (say another Jazz/Zip drive), st_dev will change --- while the
system is running.

So your claim is __still__ false.

Please try again and give a fully formed argument, and assume that
your discussion partners might know what they are talk about in the
future.

						- Ted
