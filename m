Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261936AbRE3TnA>; Wed, 30 May 2001 15:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbRE3Tmu>; Wed, 30 May 2001 15:42:50 -0400
Received: from 24.66.120.83.on.wave.home.com ([24.66.120.83]:47376 "EHLO
	trillian.adap.org") by vger.kernel.org with ESMTP
	id <S261936AbRE3Tmq>; Wed, 30 May 2001 15:42:46 -0400
Date: Wed, 30 May 2001 15:42:37 -0400
From: Edsel Adap <edsel@adap.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Edsel Adap <edsel@adap.org>, linux-kernel@vger.kernel.org
Subject: Re: ln -s broken on 2.4.5
Message-ID: <20010530154237.A27606@adap.org>
In-Reply-To: <20010530124052.A26266@adap.org> <E155Ady-0006MX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E155Ady-0006MX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, May 30, 2001 at 07:24:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 07:24:30PM +0100, Alan Cox wrote:
> > I downloaded the linux 2.4.5 sources and built and installed them on my
> > system.  Since then, I've noticed strange file system behavior:
> 
> What file system. Its find on my 2.4.5-ac with ext2

Filesystem: ext2
Architecture: i386
CPU: AMD K6-II

Christopher Cole mentioned that he saw this problem, but it went away
after a reboot.  I rebooted into 2.4.5 again and the problem seemed to
have gone away.

But now, I got something else.... something that looks like a kernel
Ooops.  I was running automake and got the following:
kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013fa2b>]
EFLAGS: 00010286

...

I'm gonna try 2.4.4 for now.  But if anyone is interested in looking
into this deeper, I can send the whole "oops" message and whatever other
info needed to debug this.


-- 
Edsel Adap
edsel@adap.org
http://www.adap.org/~edsel/          LINUX - the choice of the GNU generation

"Netscape is an application which grows to fill all available memory."  - me
