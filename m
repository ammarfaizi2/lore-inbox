Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289233AbSAIH5z>; Wed, 9 Jan 2002 02:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289229AbSAIH5q>; Wed, 9 Jan 2002 02:57:46 -0500
Received: from firewall.synchrotron.fr ([193.49.43.1]:10972 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S288546AbSAIH5h>;
	Wed, 9 Jan 2002 02:57:37 -0500
Date: Wed, 9 Jan 2002 08:57:15 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: boot messeage
Message-ID: <20020109085715.A6702@pcmaftoul.esrf.fr>
In-Reply-To: <20020109064104.15170.qmail@web15003.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20020109064104.15170.qmail@web15003.mail.bjs.yahoo.com>; from hanhbkernel@yahoo.com.cn on Wed, Jan 09, 2002 at 02:41:04PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 02:41:04PM +0800, hanhbkernel wrote:
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

Use the "Support for console on virtual terminal and output the stuff to
a non used seria port : 
append to lilo something like this: append="console=/dev/tty4"
        Sam
