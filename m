Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289292AbSAIJUV>; Wed, 9 Jan 2002 04:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289288AbSAIJUL>; Wed, 9 Jan 2002 04:20:11 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:25096 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S289294AbSAIJUB>; Wed, 9 Jan 2002 04:20:01 -0500
Message-ID: <3C3C0C17.D94FEC00@loewe-komp.de>
Date: Wed, 09 Jan 2002 10:23:35 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: hanhbkernel <hanhbkernel@yahoo.com.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: boot messeage
In-Reply-To: <20020109064104.15170.qmail@web15003.mail.bjs.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hanhbkernel schrieb:
> 
> When booting Linux, the kernel messages are shown on
> screen.
> I don't like to show these messages, so  "Support for
> console on virtual terminal" and "Support for console
> on serial port" are not chose when compiling kernel.
> But using the new kernel, computer can't boot. If one
> of "Support for console on virtual terminal" and
> "Support for console on serial port" is chose,
> Computer can be booted. If I don¡¯t like the booting
> messages shown through terminal or HyperTerminal on
> screen. Would you like to tell me how could I do?
> 

on LILO:

	append = "quiet"
or
	append = "console=/dev/tty10"
