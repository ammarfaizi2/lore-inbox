Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTBNSuP>; Fri, 14 Feb 2003 13:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbTBNSuP>; Fri, 14 Feb 2003 13:50:15 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:61195 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263991AbTBNSuO>; Fri, 14 Feb 2003 13:50:14 -0500
Date: Fri, 14 Feb 2003 19:59:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Larry McVoy <lm@bitmover.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Dillow <dillowd@y12.doe.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 3Com 3cr990 driver release
In-Reply-To: <20030214184458.GA1488@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0302141956060.1336-100000@serv>
References: <3E4C9FAA.FC8A2DC7@y12.doe.gov> <1045233209.7958.11.camel@irongate.swansea.linux.org.uk>
 <20030214151920.GA3188@work.bitmover.com> <1045241640.1353.13.camel@irongate.swansea.linux.org.uk>
 <20030214160915.GC3188@work.bitmover.com> <1045243414.1353.28.camel@irongate.swansea.linux.org.uk>
 <20030214163611.GD3188@work.bitmover.com> <Pine.LNX.4.44.0302141916490.32518-100000@serv>
 <20030214184458.GA1488@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Feb 2003, Larry McVoy wrote:

> > Are these changes/extensions documented somewhere or is a patch available?
> > My version of cssc certainly has a few problems, without patching it's 
> > very noisy.
> 
> The only change is to accept ^AHxxxxx as well as ^Ahxxxxx as the per file
> checksum.  I'm almost positive that someone posted a patch to the kernel
> which made CSSC like BK files.

cssc complains about ^Ac[C-Z] lines and dies at ^Af x lines.

bye, Roman

