Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbRESTi6>; Sat, 19 May 2001 15:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262001AbRESTis>; Sat, 19 May 2001 15:38:48 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:2569 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261985AbRESTih>; Sat, 19 May 2001 15:38:37 -0400
Date: Sat, 19 May 2001 21:38:03 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Alexander Viro <viro@math.psu.edu>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010519213803.N18853@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu> <E1517Jf-0008PV-00@the-village.bc.nu> <20010519184819.M18853@arthur.ubicom.tudelft.nl> <20010519104511.A2648@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010519104511.A2648@vitelus.com>; from aaronl@vitelus.com on Sat, May 19, 2001 at 10:45:11AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 10:45:11AM -0700, Aaron Lehmann wrote:
> On Sat, May 19, 2001 at 06:48:19PM +0200, Erik Mouw wrote:
> > One of the fundamentals of Unix is that "everything is a file" and that
> > you can do everything by reading or writing that file.
> 
> But /dev/sda/offset=234234,limit=626737537 isn't a file! ls it and see
> if it's there. writing to files that aren't shown in directory listings
> is plain evil. I really don't want to explain why. It's extremely
> messy and unintuitive.
> 
> It would be better to do this with a file that does exist, for example
> writing something to /proc/disks/sda/arguments. Then again, I don't
> even think much of dynamic file systems in the first place.

A network socket also isn't a file in a filesystem, you can't do ls on
it, it doesn't even exist until you create one, but still you use it as
a file by reading and writing it. I don't see any difference in the way
you create /dev/sda/offset=234234,limit=626737537 by just using it.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
