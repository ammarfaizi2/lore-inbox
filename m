Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSFZO5b>; Wed, 26 Jun 2002 10:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316616AbSFZO5a>; Wed, 26 Jun 2002 10:57:30 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:53254
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S316615AbSFZO53>; Wed, 26 Jun 2002 10:57:29 -0400
Subject: Re: MCE Error - 2.5.24 - Whats this?
From: Shawn Starr <spstarr@sh0n.net>
To: alexander.riesen@synopsys.COM
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020626075027.GA18667@riesen-pc.gr05.synopsys.com>
References: <1025068858.5090.1.camel@coredump> 
	<20020626075027.GA18667@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 26 Jun 2002 10:57:37 -0400
Message-Id: <1025103458.31334.1.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand that decoded result ;) 

Is it a phony result or is there a real problem with the CPU itself?
It's brand new!


On Wed, 2002-06-26 at 03:50, Alex Riesen wrote:
> On Wed, Jun 26, 2002 at 01:20:57AM -0400, Shawn Starr wrote:
> > I got this message this evening from the syslog:
> > 
> > 
> > MCE: The hardware reports a non fatal, correctable incident occured on
> > CPU 0.
> > 
> > Bank 0: 9409c00000000136
> > 
> > 
> > Is this something I should be worried about?
> > 
> > Included is the standard dmesg.
> 
> Dave Jones had a small parser for these codes:
> http://www.codemonkey.org.uk/cruft/parsemce.c
> 
> And as it seems the parser lacks a bit of information to completely
> decode the message:
> 
> ~ ./parsemce
> Status: (4) Machine Check in progress.
> Restart IP invalid.
> parsebank(0): 9409c00000000136 @ 0
>         External tag parity error
>         Uncorrectable ECC error
>         CPU state corrupt. Restart not possible
>         MISC register information valid
>         Error not corrected.
>         Error overflow
>         Memory heirarchy error
>         Request: Generic error
>         Transaction type : Data
>         Memory/IO : I/O
> 
> > Linux version 2.5.24 (root@unknown) (gcc version 3.1) #1 Sat Jun 22 14:58:48 EDT 2002
> ...
> 
> -alex
> 
-- 
Shawn Starr, sh0n.net, <spstarr@sh0n.net>
Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416.213.2001 ext 179 F: 416.213.2008

