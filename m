Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261881AbREPLi7>; Wed, 16 May 2001 07:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261882AbREPLit>; Wed, 16 May 2001 07:38:49 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:12301 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261881AbREPLip>; Wed, 16 May 2001 07:38:45 -0400
Date: Wed, 16 May 2001 13:34:56 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Nicolas Pitre <nico@cam.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516133455.C902@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home> <01051602593001.00406@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01051602593001.00406@starship>; from phillips@bonn-fries.net on Wed, May 16, 2001 at 02:59:30AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 02:59:30AM +0200, Daniel Phillips wrote:
> On Tuesday 15 May 2001 23:20, Nicolas Pitre wrote:
> > Personally, I'd really like to see /dev/ttyS0 be the first detected
> > serial port on a system, /dev/ttyS1 the second, etc.
> 
> There are well-defined rules for the first four on PC's.  The ttySx 
> better match the labels the OEM put on the box.

Nico's point is that there is a lot of linux beyond PCs. My LART[1] has
three serial ports which I didn't label at all. The official SA1100
serial driver has /dev/ttySA[0-2] allocated. Other ARM systems use
/dev/ttyS0. Guess what happens when you want to install debian-arm on
an SA1100 system. A serial device registry like we have for the sound
cards would be most welcome.


Erik

[1] StrongARM SA1100 embedded board, http://www.lart.tudelft.nl/

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
