Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbRLTAn7>; Wed, 19 Dec 2001 19:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbRLTAnt>; Wed, 19 Dec 2001 19:43:49 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:31501 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S285692AbRLTAnn>; Wed, 19 Dec 2001 19:43:43 -0500
Date: Thu, 20 Dec 2001 01:43:04 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Michael De Nil <linux@aerythmic.be>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 -> undefined reference to `local symbols ...
Message-ID: <20011220004304.GB18071@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.43.0112200109380.424-100000@LiSa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0112200109380.424-100000@LiSa>
User-Agent: Mutt/1.3.24i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 01:13:48AM +0100, Michael De Nil wrote:
> I tried now several times to 'make' the 2.4.16-kernel, but I get allways
> the same error:
> 
> ...
> a /usr/src/linux-2.4.16/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols
> in discarded section .text.exit'
> make: *** [vmlinux] Error 1

Known problem, you're probably using Debian testing. Either downgrade
your binutils, or use 2.4.17-rc2.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
