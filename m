Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136765AbRECLct>; Thu, 3 May 2001 07:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136771AbRECLck>; Thu, 3 May 2001 07:32:40 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:65296 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S136765AbRECLcZ>; Thu, 3 May 2001 07:32:25 -0400
Date: Thu, 3 May 2001 13:29:13 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Richard Polton <Richard.Polton@morganstanley.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cannot find directory on cdrom
Message-ID: <20010503132913.E27295@arthur.ubicom.tudelft.nl>
In-Reply-To: <3AF108BE.E8957686@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF108BE.E8957686@morganstanley.com>; from Richard.Polton@morganstanley.com on Thu, May 03, 2001 at 08:29:02AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 08:29:02AM +0100, Richard Polton wrote:
> I have a cdrom burnt by a friend with W2000 (I know, friends don't let
> friends use W ;-) which has (at least) one directory on it which I cannot
> see when mounting the disk under linux. I am using kernel 2.4.4 and
> the mount command is the usual
> 
> mount /dev/cdrom /mnt/cdrom -t iso9660
> 
> I have Joliet compiled into the kernel too. I can send by private email the
> first 120 blocks or so of the disk if anyone is interested. I looked at this
> with hexlify and can see the mysterious directory (s?) which is called
> 'sturf'.

Try to mount the CDROM with the option -onojoliet and see if that
helps. It once solved the problem for me, YMMV. See man mount for more
iso9660 mount options.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
