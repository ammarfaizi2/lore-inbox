Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317756AbSGPF0B>; Tue, 16 Jul 2002 01:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317757AbSGPF0A>; Tue, 16 Jul 2002 01:26:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61193 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317756AbSGPFZ7>; Tue, 16 Jul 2002 01:25:59 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IDE/ATAPI in 2.5
Date: 15 Jul 2002 22:28:43 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ah0aub$lb0$1@cesium.transmeta.com>
References: <Pine.LNX.4.10.10207112158000.20499-100000@master.linux-ide.org> <3D2E6506.7080006@zytor.com> <m165zhp9u1.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m165zhp9u1.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> > 
> > I'm talking specifically about ATAPI devices here.  As we have already covered,
> > not all ATA devices are ATAPI, but unless I'm completely off the wall, ATAPI is
> > SCSI over IDE, and should be able to be driven as such.  The lack of access to
> > that interface using the established interface mechanisms just bites.
> 
> ATAPI is SCSI like C is C++.  There are strong similarities but they
> are regulated by different groups, and have slightly different semantics.
> Last I checked cdrecord already compensates for those differences but they
> are there.
> 

This is a good analogy, and in that general vein don't forget there
are considerable differences between different versions of SCSI as
well.  Just like there are, in many ways, bigger differences between
K&R C and C99 than between contemporary C and C++.  It should be
possible to write code that handles either one, either generically
(obviously the best) or with appropriate conditionals.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
