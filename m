Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266256AbUFZSjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUFZSjs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUFZSjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:39:48 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:32263 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S266256AbUFZSjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:39:45 -0400
Date: Sat, 26 Jun 2004 20:41:59 +0200
To: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware - memory problem?
Message-ID: <20040626184159.GA20447@hh.idb.hist.no>
References: <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua> <20040624202626.GS728@washoe.rutgers.edu> <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua> <20040624212600.GW728@washoe.rutgers.edu> <20040624215856.GA728@washoe.rutgers.edu> <20040625000102.GI728@washoe.rutgers.edu> <40DBE853.4050707@hist.no> <20040625162016.GD16916@washoe.rutgers.edu> <20040626120738.GB14609@hh.idb.hist.no> <20040626154534.GF16916@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626154534.GF16916@washoe.rutgers.edu>
User-Agent: Mutt/1.5.6+20040523i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 11:45:34AM -0400, Yaroslav Halchenko wrote:
> On Sat, Jun 26, 2004 at 02:07:38PM +0200, Helge Hafting wrote:
> > On Fri, Jun 25, 2004 at 12:20:16PM -0400, Yaroslav Halchenko wrote:
> > Glad to be of help.  I hope the /proc/mtrr stuff works out, it is
> > nice to use _all_ the memory?.  How much is it?
> 1GB RAM. I've found somewhere that guy did 'disable=X' with X for all
> lines in mtrr (we have 6) and then just overrides first with 1Gb of
> write-back and then some amount for video (64M for instance) with
> uncachable. I just didn't have time to try yet :-) 
> 
> > Don't forget the complaint to the vendor.  The only way to get 
> > permanently rid of this sort of problem is when the vendors get
> > enough reactions to sloppy bioses.  Don't be silent just because
> > you found a solution, you shouldn't really have to in this case.
> I'm not sure if vendor would respect such complaint because alienware
> supports only windows and Windows doesn't have such problem seems to me.
> Anyway how to complain in the right way?
> 
Remember, you're not the only linux user in the world. :-)
If everybody with trouble complain, then they get enough complaints
that it matters.  It doesn't work if everybody thinks the're alone
and do nothing.  Note that linux is the fastest growing OS these days.

You can also let them know before you purchase.  When getting your next
machine, consider one that claims linux support.  They exist - even
laptops.  And if you get something else, let them know.  If you
inquire about a machine - ask about linux support.  Salesmen getting
a lot of that will take note.  The linux market isn't the biggest 
but cutting off 5%/10% of the market for no reason is bad business.
Linux support is easy - they don't have to do support, just sell
a box that works.

Bring a knoppix CD when looking at machines in shops - then you
can verify that they work without obvious snags like that mtrr bug.

> 'BIOS errornessly fills Memory Type Range Registers with too many
> memory ranges with wrong caching strategies' is it what is happening?
> 
About how to complain - be constructive.  Tell them that the problem is 
serious and makes the machine work much slower than the competition, 
but that it is easily fixable by setting the mtrr's up right in the bios.
You may also want to tell them that several other vendor have had
this problem - and fixed it by issuing a bios upgrade.

> > Also check if there is a newer BIOS around. :-)
> that might be usefull :-)

Helge Hafting
