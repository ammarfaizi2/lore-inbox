Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLJMpj>; Sun, 10 Dec 2000 07:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQLJMp3>; Sun, 10 Dec 2000 07:45:29 -0500
Received: from gw.brfsodrahamn.se ([195.54.141.30]:33676 "HELO
	tuttifrutti.cdt.luth.se") by vger.kernel.org with SMTP
	id <S129464AbQLJMpQ> convert rfc822-to-8bit; Sun, 10 Dec 2000 07:45:16 -0500
X-Mailer: exmh version 2.2 10/15/1999 with nmh-1.0.4
From: Hakan Lennestal <hakanl@cdt.luth.se>
Reply-To: Hakan Lennestal <hakanl@cdt.luth.se>
To: gsharp@ihug.co.nz
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11 
In-Reply-To: Your message of "Sun, 10 Dec 2000 16:26:45 +1300."
             <3A32F7F5.28557718@ihug.co.nz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sun, 10 Dec 2000 13:15:07 +0100
Message-Id: <20001210121512.A08BD418A@tuttifrutti.cdt.luth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A32F7F5.28557718@ihug.co.nz>, Gerard Sharp writes:
> Andre Hedrick wrote:
> > This has the missing ide-pci code from 2.2.
> > It stablized my BP6 on the HPT core.
> 
> The patch had a large amount of ^M's (about 1 per line), but applied
> cleanly after being passed through "sed" :)
> 
> Unfortunately, it has NOT fixed the problem :(

Hi !

For what it's worth, I did try out this patch for my problem also
without any noticable difference.

The problem being that the kernel hangs after a dma timeout in the
partition detection phase during bootup for speeds higher than udma 44.
This is an IBM-DTLA-307030 connected to a hpt366 pci card on a BH6
motherboard.

/Håkan


---------------------------------------
e-mail: Hakan.Lennestal@lu.erisoft.se |
     or Hakan.Lennestal@cdt.luth.se   |
---------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
