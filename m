Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314072AbSDKORY>; Thu, 11 Apr 2002 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314076AbSDKORR>; Thu, 11 Apr 2002 10:17:17 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:27908 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S314074AbSDKORD>; Thu, 11 Apr 2002 10:17:03 -0400
Date: Thu, 11 Apr 2002 16:16:53 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Anil Kumar <anilk@cdotd.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read Data from  Serial Port
Message-ID: <20020411141653.GF1405@arthur.ubicom.tudelft.nl>
In-Reply-To: <15541.28044.720063.458160@notabene.cse.unsw.edu.au> <Pine.OSF.4.10.10204111700160.10556-100000@moon.cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 05:08:15PM +0500, Anil Kumar wrote:
>   I am new to Linux .
>  I am looking for provisions in linux Kernel or Linux User Space  through
> which i can read  data directly from
> serial port (A device is Connected to Serial Port).

open("/dev/ttyS0"), see "man open".

>   I read the literature regarding Raw Sockets but could not figure out 
>  how to read data from serial port.

A serial port is a device file in /dev. Sockets are for networking.

>    If there is any URL where i can find  information regarding this please
> mail me that also.

You can read the Serial-Programming-HOWTO. There is also a lot of
information in the book "Advanced programming in the UNIX environment"
by W. Richard Stevens. The book is expensive, but worth its price.


Erik

PS: this kind of userland questions is off-topic for this list. Next
  time use the linux-c-programming mailing list, see
  http://lists.linux.org.au/listinfo/linuxcprogramming

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
