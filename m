Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283163AbRLIHSz>; Sun, 9 Dec 2001 02:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283158AbRLIHSp>; Sun, 9 Dec 2001 02:18:45 -0500
Received: from [63.150.225.3] ([63.150.225.3]:20747 "HELO smtp.garbersoft.net")
	by vger.kernel.org with SMTP id <S283163AbRLIHS2>;
	Sun, 9 Dec 2001 02:18:28 -0500
Date: Sun, 9 Dec 2001 00:18:24 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Robin Walser <robin.walser@usad.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x problem
Message-Id: <20011209001824.7897a3b1.dickson@permanentmail.com>
In-Reply-To: <3C0FA135.80504@usad.li>
In-Reply-To: <3C0FA135.80504@usad.li>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2001 17:47:49 +0100, Robin Walser wrote:

> Hi there,
> 
> I didn't know what to do to fix my problem, so I thought I write to 
> you.... So the following is my Problem: ..
> 
> Long years ago, I bought every time, Red Hat Linux lalala.. and so on, 
> and as I bought Red Hat Linux 7.2 there came the biggest problem I ever 
> had, when I compile kernels or oder progs then one time to the other the 
> whole computers down, and I get a message like this ....
> 
> www.usad.li/robin/fehler1.jpg
>   //                            fehler2.jpg
>  //                             fehler3.jpg

It would have helped to prefix these lines with:  http://

> So I didn't knew what to do, in ircnet I asked some people they told me 
> that it could might be a memory problem, so they said I should make a 
> memory test with memtest86 ... so I did, but there where no errors, and 
> the message came every time again, the very strange thing is that this 
> never happend until i setup red hat 7.2

The "Machine Check" means "internal error, bus error, or bus error
detected by external agent".

Verify that your CPU fan is working and your case is well ventilated. Then
if it still happens, you can add the boot option "nomce" to disable the
machine check exception.

Beyond this, you'll have to get help from someone else.

	-Paul

> uname -a
> Linux firebird 2.4.7-10 #1 Thu Sep 6 16:46:36 EDT 2001 i686 unknown
> 
> gcc -v
> 
> gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
> 
> My environment :
> 
> 
> AMD xxx 1,2 GHz
> 512 MB RAM
> 40 GB Harddisk
> Riva TNT 2
> and so on (its a futjsu siemens machine )
