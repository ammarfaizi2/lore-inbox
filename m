Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314103AbSDLRdf>; Fri, 12 Apr 2002 13:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314107AbSDLRde>; Fri, 12 Apr 2002 13:33:34 -0400
Received: from ns.suse.de ([213.95.15.193]:47366 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314103AbSDLRde>;
	Fri, 12 Apr 2002 13:33:34 -0400
Date: Fri, 12 Apr 2002 19:33:33 +0200
To: Vahid Fereydunkolahi <fereydunk@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Developing kernel.
Message-ID: <20020412173332.GA3227@suse.de>
In-Reply-To: <20020412171310.80484.qmail@web10001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-OS: Linux 2.4.18 alpha
From: stepan@suse.de (Stefan Reinauer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vahid Fereydunkolahi <fereydunk@yahoo.com> [020412 19:13]:
>  I am interested to be involved in kernel development.
> 
>  Anything I can do?

There's a lot of directions you can go to when doing Linux Kernel
development. 

One interesting way to go would be implementing a general Open Firmware
interface for the Linux Kernel. The needed code is there already, as
Sparc and some PPC machines use Open Firmware per default. New Open
Firmware implementations for other platforms, such as i386, x86-64,
alpha, arm and such could really use a generalized interface in the
Linux Kernel as this would make the process of implementing the Client
(Operating System) Interface of such a firmware much easier.
Open BIOS is that approach of writing a free and portable Open Firmware
implementation. 
Find more information on OpenBIOS at http://www.freiburg.linux.de/OpenBIOS/
or generic documents on Open Firmware at 
http://www.freiburg.linux.de/OpenBIOS/docs/
Any questions are of course welcome.

Best regards,
  Stefan Reinauer
  
-- 
Ok hex 4666 dup negate do i 4000 dup 2* negate do " *" 0 dup 2dup 1e 0 do
 2swap * e >>a 2* 5 pick + -rot - j + dup dup * e >>a rot dup dup * e >>a 
  rot swap 2dup + 10000 > if 3drop 3drop "  " 0 dup 2dup leave then loop 
              2drop 2drop type 268 +loop cr drop 5de +loop
