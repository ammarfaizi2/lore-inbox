Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUFZPpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUFZPpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 11:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267177AbUFZPpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 11:45:40 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:10982 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S267176AbUFZPpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 11:45:38 -0400
Date: Sat, 26 Jun 2004 11:45:34 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware - memory problem?
Message-ID: <20040626154534.GF16916@washoe.rutgers.edu>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040624191026.GP728@washoe.rutgers.edu> <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua> <20040624202626.GS728@washoe.rutgers.edu> <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua> <20040624212600.GW728@washoe.rutgers.edu> <20040624215856.GA728@washoe.rutgers.edu> <20040625000102.GI728@washoe.rutgers.edu> <40DBE853.4050707@hist.no> <20040625162016.GD16916@washoe.rutgers.edu> <20040626120738.GB14609@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626120738.GB14609@hh.idb.hist.no>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 02:07:38PM +0200, Helge Hafting wrote:
> On Fri, Jun 25, 2004 at 12:20:16PM -0400, Yaroslav Halchenko wrote:
> Glad to be of help.  I hope the /proc/mtrr stuff works out, it is
> nice to use _all_ the memory?.  How much is it?
1GB RAM. I've found somewhere that guy did 'disable=X' with X for all
lines in mtrr (we have 6) and then just overrides first with 1Gb of
write-back and then some amount for video (64M for instance) with
uncachable. I just didn't have time to try yet :-) 

> Don't forget the complaint to the vendor.  The only way to get 
> permanently rid of this sort of problem is when the vendors get
> enough reactions to sloppy bioses.  Don't be silent just because
> you found a solution, you shouldn't really have to in this case.
I'm not sure if vendor would respect such complaint because alienware
supports only windows and Windows doesn't have such problem seems to me.
Anyway how to complain in the right way?

'BIOS errornessly fills Memory Type Range Registers with too many
memory ranges with wrong caching strategies' is it what is happening?

> Also check if there is a newer BIOS around. :-)
that might be usefull :-)

-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

