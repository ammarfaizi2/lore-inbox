Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131799AbQJ2P1A>; Sun, 29 Oct 2000 10:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131844AbQJ2P0v>; Sun, 29 Oct 2000 10:26:51 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:54544 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S131832AbQJ2P0n>; Sun, 29 Oct 2000 10:26:43 -0500
Date: Sun, 29 Oct 2000 16:26:33 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Jerry Kelley <jkelley@iei.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc question (off topic)
Message-ID: <20001029162633.B1198@arthur.ubicom.tudelft.nl>
In-Reply-To: <001801c041bb$5e894c80$0a00a8c0@gamma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001801c041bb$5e894c80$0a00a8c0@gamma>; from jkelley@iei.net on Sun, Oct 29, 2000 at 10:17:36AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 10:17:36AM -0500, Jerry Kelley wrote:
> Can gcc generate ASM output with the source lines from the C file
> interspersed as comments?

Yes, "gcc -S". Look in the gcc info pages for more information (the man
page in known to be outdated).

If that isn't what you want, try "objdump -D -S" on the generated
object file. You have to use the "-g" flag for gcc to let this trick
work.


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
