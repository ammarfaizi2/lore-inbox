Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbTCRBJV>; Mon, 17 Mar 2003 20:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbTCRBJV>; Mon, 17 Mar 2003 20:09:21 -0500
Received: from [66.186.193.1] ([66.186.193.1]:43532 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262065AbTCRBJU>; Mon, 17 Mar 2003 20:09:20 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 20:30:59(EST) on March 17, 2003
X-HELO-From: rohan.arnor.net
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: Re: (2.5.65) Unresolved symbols in modules?
From: Torrey Hoffman <thoffman@arnor.net>
To: Vincent Hanquez <tab@tuxfamily.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030318005612.GA1529@darwin.crans.org>
References: <1047948471.12620.9.camel@rohan.arnor.net> 
	<20030318005612.GA1529@darwin.crans.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Mar 2003 17:19:17 -0800
Message-Id: <1047950384.12620.18.camel@rohan.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-17 at 16:56, Vincent Hanquez wrote:
> On Mon, Mar 17, 2003 at 04:46:57PM -0800, Torrey Hoffman wrote:
> > and then:
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.65; fi
>                              ^^^^^^^^^^^^
> you seem to use old depmod (not /usr/local/sbin/depmod)

Ah, of course.  I followed the instructions that came with the
module-init-tools, and then just used "make modules_install".  
So much for following instructions.

I can only make the general observation that it would be helpful if:
- module-init-tools documentation pointed out this drawback of
installing to /usr/local/sbin
- module-init-tools documentation stated if it is or is not backward
compatible for the 2.4 kernels  (is it?)
- The kernel makefile used the module tools under /usr/local/sbin if
they exist.

(sigh)

Anyway, thanks again for the advice.

Torrey Hoffman
thoffman@arnor.net




