Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422936AbWBIRy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422936AbWBIRy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422935AbWBIRy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:54:58 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:31418 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1422931AbWBIRy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:54:58 -0500
Date: Thu, 9 Feb 2006 12:54:56 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060209175456.GX2478@csclub.uwaterloo.ca>
References: <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD> <20060208211455.GC2480@csclub.uwaterloo.ca> <20060208212629.GB27240@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208212629.GB27240@merlin.emma.line.org>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 10:26:29PM +0100, Matthias Andree wrote:
> In case you missed it, I wrote a patch for libscg and posted it here
> last week, and as it actually shrinks the code, it would benefit other
> systems as well - albeit only by reducing their download size.

Yes I saw that.  Of course it has to be maintained so it applies to new
versions of cdrecord, since apparently fixes for such things are not
going to be accepted upstream.

> That my patch doesn't do, but it unifies /dev/sg* and /dev/hd* into one
> view (no more ATA:1,2,3, just 1,2,3 will do, as will /dev/hdc or
> /dev/sg3).

Well that certainly does fix some of the issues.

Len Sorensen
