Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129269AbQKFRVy>; Mon, 6 Nov 2000 12:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbQKFRVp>; Mon, 6 Nov 2000 12:21:45 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:22289 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129758AbQKFRVg>; Mon, 6 Nov 2000 12:21:36 -0500
Date: Mon, 6 Nov 2000 18:20:59 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Michael Vines <mjvines@undergrad.math.uwaterloo.ca>
Cc: Catalin BOIE <util@deuroconsult.ro>, linux-kernel@vger.kernel.org
Subject: Re: Kernel hook for open
Message-ID: <20001106182059.G12348@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001106155702.F12348@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10011061009490.9936-100000@barkingdogstudios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10011061009490.9936-100000@barkingdogstudios.com>; from mjvines@undergrad.math.uwaterloo.ca on Mon, Nov 06, 2000 at 10:11:11AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 10:11:11AM -0500, Michael Vines wrote:
> On Mon, 6 Nov 2000, Erik Mouw wrote:
> > Use LD_PRELOAD instead.
> 
> You could also write a simple kernel module that replaces the open system
> call.  See the Linux Kernel Module Programming Guide for details. 
> http://www.linuxdoc.org/guides.html
> 
> specifically http://www.linuxdoc.org/LDP/lkmpg/node20.html

Why difficult when it can be done easy? To test the Y2K readiness of
some programs (yeah, Y2K, remember?), I wrote a small library that
overloaded the time() and gettimeofday() syscalls in about 100 lines of
code. No kernel modules needed, no root privileges needed, just set the
environment variable LD_PRELOAD and off you go.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
