Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261898AbRESQur>; Sat, 19 May 2001 12:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261902AbRESQuh>; Sat, 19 May 2001 12:50:37 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:25872 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261898AbRESQuV>; Sat, 19 May 2001 12:50:21 -0400
Date: Sat, 19 May 2001 18:48:19 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010519184819.M18853@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu> <E1517Jf-0008PV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1517Jf-0008PV-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, May 19, 2001 at 03:02:47PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 03:02:47PM +0100, Alan Cox wrote:
> > ioctls are evil, period. At least with these names you can use normal
> > scripting and don't need any special tools. Every ioctl means a binary
> > that has no business to exist.
> 
> That is not IMHO a rational argument. It isn't my fault that your shell does
> not support ioctls usefully. If you used perl as your login shell you would
> have no problem there.

Sure, you're right, but Al's point is that you shouldn't need to.

One of the fundamentals of Unix is that "everything is a file" and that
you can do everything by reading or writing that file. The devices are
the big exception, they need ioctls to control them. With Al's proposal
we can get rid of the ioctls and let the devices behave like normal
files.


Erik
[who remembers a discussion like this years ago on comp.os.linux.kernel
 with similar conclusion: ioctls are bad, we should get rid of them]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
