Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130610AbRBWWUY>; Fri, 23 Feb 2001 17:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130624AbRBWWUO>; Fri, 23 Feb 2001 17:20:14 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:32019 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130610AbRBWWUD>; Fri, 23 Feb 2001 17:20:03 -0500
Date: Fri, 23 Feb 2001 23:19:49 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Chris Mason <mason@suse.com>
Cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <20010223231949.D24959@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl> <730960000.982966246@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <730960000.982966246@tiny>; from mason@suse.com on Fri, Feb 23, 2001 at 05:10:46PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 05:10:46PM -0500, Chris Mason wrote:
> Many thanks for sending along a test program for reproducing.  But, it
> doesn't seem to reproduce the problem here, how many times did you have to
> run it to see the null bytes?  Do you remove the files between runs?

I got them immediately at the first run, which more or less was what I
expected because reiserfs ate one of my mailfolders that way (only a
CVS log folder, so nothing special was lost). You have to remove the
files between runs, otherwise the same blocks seem to be allocated to
the files.

I'll upgrade to linux-2.4.2 to see if it solves the problem. (was
running 2.4.2-pre4 + your patch)


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
