Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289885AbSAKF4Y>; Fri, 11 Jan 2002 00:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289886AbSAKF4D>; Fri, 11 Jan 2002 00:56:03 -0500
Received: from zok.sgi.com ([204.94.215.101]:9121 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289885AbSAKF4C>;
	Fri, 11 Jan 2002 00:56:02 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Boman <aboman@goofy.nerdfest.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 has 2 modules named sym53c8xx.o 
In-Reply-To: Your message of "Fri, 11 Jan 2002 00:00:52 CDT."
             <20020111000052.34204997.aboman@goofy.nerdfest.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Jan 2002 16:55:49 +1100
Message-ID: <3452.1010728549@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002 00:00:52 -0500, 
Andreas Boman <aboman@goofy.nerdfest.org> wrote:
>It seems a new sym53c8xx was added in 2.4.17, and now there are 2 modules,
>both named sym53c8xx.o (CONFIG_SCSI_SYM53C8XX and
>CONFIG_SCSI_SYM53C8XX_2). This was noticed since my mkinitrd script isn't
>smart enough to destinguish the two. Leading to the question how does
>modprobe?

It does not.  Two modules with the same name give undefined results for
modprobe, insmod, initrd etc.

