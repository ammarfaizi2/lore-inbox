Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSILPlZ>; Thu, 12 Sep 2002 11:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSILPlZ>; Thu, 12 Sep 2002 11:41:25 -0400
Received: from 62-190-219-3.pdu.pipex.net ([62.190.219.3]:27404 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S316541AbSILPlY>; Thu, 12 Sep 2002 11:41:24 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209121553.g8CFrrEh003646@darkstar.example.net>
Subject: Re: XFS?
To: martin.knoblauch@mscsoftware.com
Date: Thu, 12 Sep 2002 16:53:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209121727.50745.martin.knoblauch@mscsoftware.com> from "Martin Knoblauch" at Sep 12, 2002 05:27:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> In my opinion the non-inclosure in the mainline kernel is the most 
> >> important reason not to use XFS (or any other FS). Which in turn 
> >> massively reduces the tester base. It is a shame, because for some 
> type 
> >> of applications it performs great, or better than anything else. 
> >
> >
> >On the other hand, filesystem corruption bugs are one of the worst type 
> >to suffer from. We absolutely don't want to include filesystems 
> >without at least a reasonable proven track record in the mainline 
> >kernel, and therefore encourage the various distributions to use them, 
> >incase any bugs do show up. Look how long a buffer overflow existed in 
> >Zlib unnoticed. 
> 
> If enclosure in "major" distribuitons defines mainline for you, I have 
> to agree. Otherwise, how do you get "a  proven track record in 
> mainline" without having it in the mainline kernel ? :-)

Sorry, I meant we should be wary about what is moved from being development code to non-development code in the stable kernel.

>  In any case, one could always mark XFS as "experimental" for some time.

Exactly, I think we should.

The distributions will 'mirror' that, by including support, but not making it obvious unless you poke around looking for it - so it gets the new feature out to the more users, but doesn't present it as just another option for newbies to select without realising what they are doing.

> >EXT2 is a very capable filesystem, and has *years* of proven 
> >reliability. That's why I'm not going to switch away from it for 
> >critical work any time soon. 
> 
> sure, if you can live with the fsck time on your 200 GB (or bigger) 
> filesystem after the occasional crash.

But Linux doesn't crash...  :-)

John.
