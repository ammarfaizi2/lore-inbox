Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbRCAB2l>; Wed, 28 Feb 2001 20:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRCAB2d>; Wed, 28 Feb 2001 20:28:33 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51676 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129429AbRCAB2N>;
	Wed, 28 Feb 2001 20:28:13 -0500
Date: Thu, 1 Mar 2001 01:27:17 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: David Anderson <daveanderson@eudoramail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't compilete 2.4.2 kernel
Message-ID: <20010301012717.W25658@arthur.ubicom.tudelft.nl>
In-Reply-To: <HDPBFHJNMFALDAAA@shared1-mail.whowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <HDPBFHJNMFALDAAA@shared1-mail.whowhere.com>; from daveanderson@eudoramail.com on Wed, Feb 28, 2001 at 09:32:09AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 09:32:09AM -0500, David Anderson wrote:
> *CC daveanderson@eudoramail.com* on reply.
> 
> ln -s linux-2.4 linux 
> 
> That helps a bit.  Here's what I get now when doing 'make bzImage':
> 
> In file included from /usr/src/linux/include/linux/string.h:21,
> from /usr/src/linux/include/linux/fs.h:23,
> from /usr/src/linux/include/linux/capability.h:17,
> from /usr/src/linux/include/linux/binfmts.h:5,
> from /usr/src/linux/include/linux/sched.h:9,
> from /usr/src/linux/include/linux/mm.h:4,
> from /usr/src/linux/include/linux/slab.h:14,
> from /usr/src/linux/include/linux/proc_fs.h:5,
> from init/main.c:15:
> /usr/src/linux/include/asm/string.h:305: `current' undeclared (first use in this function)
> /usr/src/linux/include/asm/string.h: In function `__memcpy3d':
> /usr/src/linux/include/asm/string.h:312: `current' undeclared (first use in this function)
> make: *** [init/main.o] Error 1

Known problem. Disable "SMP support" for Athlon CPUs.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
