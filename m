Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281102AbRKKVzg>; Sun, 11 Nov 2001 16:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281103AbRKKVzZ>; Sun, 11 Nov 2001 16:55:25 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:30980 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S281102AbRKKVzP>; Sun, 11 Nov 2001 16:55:15 -0500
Date: Sun, 11 Nov 2001 22:47:18 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Femitha Majeed <m_femitha@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel paging request at virtual address....
Message-ID: <20011111224718.G22082@arthur.ubicom.tudelft.nl>
In-Reply-To: <F1336POYFSrAuWiqJmd000226c0@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F1336POYFSrAuWiqJmd000226c0@hotmail.com>; from m_femitha@hotmail.com on Sat, Nov 10, 2001 at 04:23:03AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 04:23:03AM +0000, Femitha Majeed wrote:
> I am trying to write a kernel module which reads the files in the /proc 
> directory.

The idea behind /proc is that it allows userland to read or write
certain kernel variables. You shouldn't read a /proc file from within
the kernel.

> When I do an insmod filename.o, I get the following error:
> Unable to handle kernel paging request at virtual address....
> 
> In the module, I use kmalloc to allocate memory. Is that the reason I am 
> getting this error?

Without having your source it's impossible to tell. Please read the
procfs guide in your kernel tree or at
http://www.kernelnewbies.org/documents/ .

> I am very new to writing kernel modules, I would really appreciate a reply.

Go to the www.kernelnewbies.org website and subscribe to the
kernelnewbies mailing list. The #kernelnewbies IRC channel is also
quite helpful.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
