Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWBMOKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWBMOKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWBMOKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:10:09 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:45034 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751776AbWBMOKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:10:08 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 15:07:55 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F092BB.nailKUSH1YIP1@burner>
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner>
 <Pine.LNX.4.61.0602121101070.25363@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602121101070.25363@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >> > > The struct stat->st_rdev field need to be stable too to comply to POSIX?
> >> > Correct.
> >A particular file on the system must not change st_dev while the system
> >is running.
> >
>
> Attention, I asked for st_rdev (=major/minor as presented in ls -l),
> not st_dev (major/minor of the disk /dev is on).

I was of course talking about st_dev

But as a note: st_rdev from the device carrying the FS becomes st_dev
for all files inside a particular FS.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
