Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbREWN1d>; Wed, 23 May 2001 09:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbREWN1X>; Wed, 23 May 2001 09:27:23 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:48914 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263079AbREWN1L>; Wed, 23 May 2001 09:27:11 -0400
Message-ID: <3B0BBA8C.24928A94@idb.hist.no>
Date: Wed, 23 May 2001 15:26:36 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105231229.OAA19155.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
>     From alan@lxorguk.ukuu.org.uk Wed May 23 14:16:46 2001
> 
>     > It is entirely possible to remove all partition table handling code
>     > from the kernel. User space can figure out where the partitions
>     > are supposed to be and tell the kernel.
>     > For the initial boot this user space can be in an initrd,
>     > or it could just be a boot parameter: rootdev=/dev/hda,
>     > rootpartition:offset=N,length=L, rootfstype=ext3.
> 
>     Not if you want compatibility.
> 
> I don't think compatibility is a problem.
> It would go like this: at configure time you get the
> choice of the default initrd or a custom initrd.

But I don't want an initrd.  I want to get the root fs directly from
disk the way I always have.  Initrd may be useful for install floppies
and such, not something I want for an ordinary installed system.

The kernel parameter way is better, just add to lilo.conf
and it works.  Forcing an initrd is also incompatibility,
because I don't use one now.

Helge Hafting
