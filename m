Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbREBKXU>; Wed, 2 May 2001 06:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbREBKXL>; Wed, 2 May 2001 06:23:11 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:63992 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132536AbREBKWx>; Wed, 2 May 2001 06:22:53 -0400
Date: Wed, 2 May 2001 12:22:50 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maximum files per Directory
Message-ID: <20010502122250.J3305@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <272800000.988750082@hades> <E14uhI2-0002NH-00@the-village.bc.nu> <9cnbs0$uk3$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9cnbs0$uk3$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, May 01, 2001 at 03:03:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 03:03:44PM -0700, H. Peter Anvin wrote:
> > Bit of both. You exceeded the max link count, and your
> > performance would have been abominable too. cyrus should be
> > using heirarchies of directories for very large amounts of
> > stuff.
Right.

> But also showing, once again, that this particular scalability problem
> really is a headache for some people.

If you do ls on that directory as an admin, you'll see, what the
REAL cause of this headache is: 

            The application doing such stupid thing!

People (writing applications) building up such large directories
should be forced to read every entry of it aloud. 

Then they'll learn[1] and the problem is solved.

Regards

Ingo Oeser

[1] If not, let them repeat until they do.
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
