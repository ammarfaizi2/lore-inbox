Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbSKLKub>; Tue, 12 Nov 2002 05:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266445AbSKLKub>; Tue, 12 Nov 2002 05:50:31 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:45322 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S266434AbSKLKua>; Tue, 12 Nov 2002 05:50:30 -0500
Message-ID: <3DD0DEA6.BA3DCBA3@aitel.hist.no>
Date: Tue, 12 Nov 2002 11:57:42 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: rudmer@legolas.dynup.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
References: <20021112013244.GF1729@mythical.michonline.com> <Pine.GSO.4.21.0211112039430.29617-100000@steklov.math.psu.edu> <20021112080417.GA11660@think.thunk.org> <20021112083811Z266406-32598+5165@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudmer van Dijk wrote:

> 
> from a user point of view it is better to keep it because it could really
> simplify a users life except ide should be just in discs as hdX and not as
> /dev/ide/hostN/busX/targetY/lunZ/disc ...

Use /dev/discs if that's what you like.  The /dev/ide/hostN...
alternative is there for a reason though.

If you have, say 3 ide controllers and remove a disk
from the second one then disks on the third is renumbered 
if they're in /dev/discs.  The ones in /dev/ide/host2/...
stays put.

Desktop machines may not need all that with one disk only,
but it is useful for servers using IDE drives.

Helge Hafting
