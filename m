Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289329AbSAOBbp>; Mon, 14 Jan 2002 20:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289344AbSAOBbZ>; Mon, 14 Jan 2002 20:31:25 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:22662
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289329AbSAOBbR>; Mon, 14 Jan 2002 20:31:17 -0500
Date: Mon, 14 Jan 2002 18:30:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Justin Carlson <justincarlson@cmu.edu>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020115013025.GA3814@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020114145035.E17522@thyrsus.com> <1011040246.19071.42.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1011040246.19071.42.camel@gs256.sp.cs.cmu.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 03:30:46PM -0500, Justin Carlson wrote:

> From the other side, how does having the ability to probe local hardware
> hurt?  It should be cleanly seperable from the classical build process
> for the purists, and helpful to some (I think) significant portion of
> the userbase, particularly those folks who like to test bleeding edge
> stuff on a variety of hardware.  I don't really understand the
> resistance to the idea of someone going out and implementing this.

Right, and this is 95% possible even.  Doing PCI stuff is rather easy
(since we've got it all mapped out even).  The problem is the 100%
point-click-run goal that Eric has.

The original sticking point was doing ISA (and other buses that are
_not_ autodetect friendly in a safe way).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
