Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314239AbSEMQhk>; Mon, 13 May 2002 12:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314242AbSEMQhj>; Mon, 13 May 2002 12:37:39 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:11787 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314239AbSEMQhU>; Mon, 13 May 2002 12:37:20 -0400
Date: Mon, 13 May 2002 17:37:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: rpm <rajendra.mishra@timesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ADS GCP reboots when running the application!
Message-ID: <20020513173714.F6024@flint.arm.linux.org.uk>
In-Reply-To: <200205131138.g4DBcU526690@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 05:08:30PM +0530, rpm wrote:
>     The kernel is not showing any OOPS or panic  , it just reboots !

Weird.  Tried any more recent kernels?

> what i think is that some double fault ( fault inside fault handler )

No such thing on ARMs.  If you take a fault while handling one, you
re-enter the fault handler - you don't reboot.

Alternatively, you could send the ARM Linux mailing lists/me a binary
to try on various other ARM machines/kernels.  (see
http://www.arm.linux.org.uk/armlinux/mailinglists.php)

(Note, I'm unlikely to get time to try it here, between trying to get
2.5.15 working, trying to review patches people have sent over the
last two weeks, maybe actually applying some of them, sending stuff
to Linus, finding and killing bugs, tackling the odd hardware failure,
updating my web diary, and maybe even producing an ARM patch for
something later than 2.5.10-rmk1 which was released a fortnight last
Sunday ago.) ;(

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

