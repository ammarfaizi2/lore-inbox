Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130676AbRAGLwU>; Sun, 7 Jan 2001 06:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130758AbRAGLwK>; Sun, 7 Jan 2001 06:52:10 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:53256 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130676AbRAGLvx>;
	Sun, 7 Jan 2001 06:51:53 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: Pixel@the-babel-tower.nobis.phear.org (Nicolas Noble),
        linux-kernel@vger.kernel.org (Linux-kernel's Mailing list)
Subject: Re: Little question about modules... 
In-Reply-To: Your message of "Sun, 07 Jan 2001 09:58:47 -0000."
             <200101070958.f079wmx22407@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Jan 2001 22:51:43 +1100
Message-ID: <31837.978868303@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001 09:58:47 +0000 (GMT), 
Russell King <rmk@arm.linux.org.uk> wrote:
>Nicolas Noble writes:
>> Why do I have used by -1 for the module ipv6 onto my system?
>
>I guess this is going to be a new FAQ!  Can we add it to the lkml FAQ
>please?

>From man insmod in modutils 2.4.1 (not released yet).

  If the module controls its own unloading via a can_unload routine
  then the user count displayed by lsmod is always -1, irrespective of
  the real use count.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
