Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbRFBWnU>; Sat, 2 Jun 2001 18:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbRFBWnK>; Sat, 2 Jun 2001 18:43:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22547 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262009AbRFBWm6>; Sat, 2 Jun 2001 18:42:58 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3B196BE4.79CFFAF4@transmeta.com>
Date: Sat, 02 Jun 2001 15:42:44 -0700
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: missing sysrq
In-Reply-To: <Pine.LNX.4.10.10106011050380.2614-100000@coffee.psychology.mcmaster.ca> <20010601203841Z261493-933+3160@vger.kernel.org> <9f97hu$83v$1@cesium.transmeta.com> <20010602230815.A22390@flint.arm.linux.org.uk> <3B19646F.CBB6DB65@transmeta.com> <20010602233920.A23300@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Sat, Jun 02, 2001 at 03:10:55PM -0700, H. Peter Anvin wrote:
> > That seems like a very bad idea.  What if there is a boot script bug?
> 
> Also think about kernel panics - the only thing that works after that
> is the power or (if you have it connected) reset button.  ctrl-alt-del
> needs keventd to work, and since sysrq-b is disabled by default...
> 
> However, IMHO that is a non-point because you need to be physically
> at the system either way to solve the problem.
> 

Not true if you have a serial console (and SysRq over serial console
happens to work correctly that day.)  Assuming this change is corrected
to be sane.

	-hpa
