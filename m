Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbTLWA0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbTLWA0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:26:49 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:3085 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264583AbTLWA0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:26:47 -0500
Date: Mon, 22 Dec 2003 16:26:41 -0800
From: jw schultz <jw@pegasys.ws>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SCO's infringing files list
Message-ID: <20031223002641.GD28269@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com> <Pine.LNX.4.58.0312221337010.6868@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312221337010.6868@home.osdl.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: If you're running Outlook, look out!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 01:55:00PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 22 Dec 2003, Tom Felker wrote:
> > 
> > The original errno.h, from linux-0.01, says it was taken from minix, and goes 
> > up to 40.
> 
> Good eyes - I only analysed the ctype.h thing, and didn't look up errno.h
> in the original sources. errno.h has a _big_ comment saying where the
> numbers came from (and some swearwords about POSIX ;)
> 
> Looking at signal.h, those numbers also seem to largely match minix. Which
> makes sense - I actually had access to them.  
> 
> In both cases it's only the numbers that got copied, though. And not all
> of them either - for some reason I tried to make the signal numbers match
> (probably lazyness - not so much that I cared about the numbers
> themselves, but about the list of signal names), but for example the
> SA_xxxx macros - in the very same file - bear no relation to the minix
> ones.

And for the names, perhaps they would care to sue The Open
Group?
http://www.opengroup.org/onlinepubs/007904975/basedefs/signal.h.html
And that probably applies to the rest of these header files.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
