Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUCPMmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCPMmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:42:54 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:51193 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S261364AbUCPMmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:42:52 -0500
Date: Tue, 16 Mar 2004 13:42:39 +0100 (MET)
Message-Id: <200403161242.i2GCgd426863@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: raven@themaw.net
CC: hallyn@CS.WM.EDU, linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0403141032230.4585@raven.themaw.net> (message from
	Ian Kent on Sun, 14 Mar 2004 10:33:00 +0800 (WST))
Subject: Re: unionfs
References: <200403080952.i289qsU12658@kempelen.iit.bme.hu>
 <20040311151343.GA943@escher.cs.wm.edu> <200403111544.i2BFi7O06675@kempelen.iit.bme.hu> <Pine.LNX.4.58.0403141032230.4585@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'll have to, as this is needed for AVFS.  Not unionfs, but something
> > similar, that allows file/directory lookups for special filenames to
> > be redirected to another filesystem.
> 
> I have a need for this in autofs4 also.

What are your exact requirements?  I mean, do you want to check every
lookup, or only if the lookup returned a negative dentry?  Is it a
fixed set of names that you need to check or is it dynamic?

Thanks,
Miklos
