Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264998AbRGEMkg>; Thu, 5 Jul 2001 08:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbRGEMk0>; Thu, 5 Jul 2001 08:40:26 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:3588 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S264998AbRGEMkL>; Thu, 5 Jul 2001 08:40:11 -0400
Date: Thu, 5 Jul 2001 14:39:44 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Cyril ADRIAN <c.adrian@alplog.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols since 2.4.5 ?
Message-ID: <20010705143944.J30999@arthur.ubicom.tudelft.nl>
In-Reply-To: <873d8b4kve.fsf@galaxie.alplog.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <873d8b4kve.fsf@galaxie.alplog.net>; from c.adrian@alplog.fr on Thu, Jul 05, 2001 at 02:32:21PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 02:32:21PM +0200, Cyril ADRIAN wrote:
>     In short, since  2.4.5 I seem not  to be able to install  a kernel (depmod
> says "unresolved  symbols").  2.4.6  shows the  same problem but  as far  as I
> remember  2.4.4 did  not.   The sources  I  use are  downloaded  straight from
> www.kernel.org and I always use the same .config file.
> 
>     Relevant data  about my machine: PC  Pentium III, 320 Mo,  UDMA disks, and
> the OS is Debian GNU/Linux 2.2r3 ("Potato"). Currently I run a 2.4.1 kernel.

Looks like your system has an old version of modutils. You need Adrian
Bunk's linux-2.4 packages for running linux-2.4.* with Debian potato.
Add the following two lines to /etc/apt/sources.list:

deb http://people.debian.org/~bunk/debian potato main
deb-src http://people.debian.org/~bunk/debian potato main

Now run 'apt-get update ; apt-get dist-upgrade' and rebuild the kernel.


Erik
[happily running linux-2.4.6-pre8 on potato]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
