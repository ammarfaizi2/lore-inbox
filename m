Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129505AbQKGPeJ>; Tue, 7 Nov 2000 10:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129731AbQKGPeA>; Tue, 7 Nov 2000 10:34:00 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:17171 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129505AbQKGPds>; Tue, 7 Nov 2000 10:33:48 -0500
Date: Tue, 7 Nov 2000 16:33:25 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Abel Muñoz Alcaraz <abel@trymedia.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: A question about memory fragmentation
Message-ID: <20001107163325.F20883@arthur.ubicom.tudelft.nl>
In-Reply-To: <CAEBJLAGJIDLDINHENLOGEMOCGAA.abel@trymedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <CAEBJLAGJIDLDINHENLOGEMOCGAA.abel@trymedia.com>; from abel@trymedia.com on Tue, Nov 07, 2000 at 04:20:20PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 04:20:20PM +0100, Abel Muñoz Alcaraz wrote:
> 	I have a question for you; How Linux avoids the memory fragmentation in
> linked lists?
> 
> 	Windows 9x/NT/2000 (sorry, ;-)), have specific functions (like List_Create,
> ExInitializeSListHead, ...) to create generic linked lists but I don't find
> something similar in Linux.
> 	Has Linux a generic linked list management API ?

Yes.

> 	Must I develop this?

No.

> 	Is the kernel memory fragmentation a solved problem in Linux? (I wish it).

My guess is that the slab allocator solves this, but I don't know that
much about the MM.

> 	I have develop my own API but I don't know if Linux can do this for me.

Have a look in include/linux/list.h.

Or install jadetex and the DocBook style sheets and type "make psdocs"
in the kernel tree. That will create the file
Documentation/DocBook/kernel-api.ps in which the linked list API (and
much more) is described.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
