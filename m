Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285068AbRLFJRV>; Thu, 6 Dec 2001 04:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285064AbRLFJRM>; Thu, 6 Dec 2001 04:17:12 -0500
Received: from adsl-62-128-214-206.iomart.com ([62.128.214.206]:25586 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S285063AbRLFJRB>; Thu, 6 Dec 2001 04:17:01 -0500
Date: Thu, 6 Dec 2001 09:14:18 +0000
From: Andy Jeffries <lkml@andyjeffries.co.uk>
To: linux-kernel@vger.kernel.org
Subject: SMTP->Windows connection with 2.4.16
Message-Id: <20011206091418.4d031a5c.lkml@andyjeffries.co.uk>
Organization: Scramdisk Linux
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Guys,

A friend of mine is having a problem connecting to Blueyonder's SMTP
server with a 2.4.16 Kernel.  He has helpfully provided the following
information to illustrate the problem.  Is this a known issue with 2.4.16?
 Can anyone help?  If so, what more information do you need (tcpdump
output, .config file, ...?)

# telnet smtp.blueyonder.co.uk 25 

Connection refused

# ping smtp.blueyonder.co.uk

Replied normally

# telnet <any other mail server including Telewest's inbound one> 25

Worked fine

# nmap -sS -P 25 smtp.blueyonder.co.uk

Showed the port as open

# nmap -sT -P 25 smtp.blueyonder.co.uk

Showed the port as closed

After this, he rebooted back in to the RedHat 2.4.9 Kernel (RedHat 7.2
with updates applied) and it was all fine.  Unfortunately he had already
fired off a nasty email to Blueyonder's tech support (but it serves them
right for running a Microsoft server).

Cheers,


-- 
Andy Jeffries                   | Scramdisk Linux Project
http://www.scramdisklinux.org   | Lead developer

"testing? What's that? If it compiles, it is good, if it boots up 
 it is perfect."
  --- Linus Torvalds
