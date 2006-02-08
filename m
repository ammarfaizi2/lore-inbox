Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWBHV0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWBHV0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWBHV0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:26:35 -0500
Received: from mail.gmx.de ([213.165.64.21]:52113 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965111AbWBHV0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:26:35 -0500
X-Authenticated: #428038
Date: Wed, 8 Feb 2006 22:26:29 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060208212629.GB27240@merlin.emma.line.org>
Mail-Followup-To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	linux-kernel@vger.kernel.org
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD> <20060208211455.GC2480@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208211455.GC2480@csclub.uwaterloo.ca>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2006, Lennart Sorensen wrote:

> Hmm, perhaps what should be done is that someone needs to write and
> maintain a patch that linux users can apply to cdrecord (since other OSs
> are different and hence have no reason to use such a patch), to make it
> behave in a manner which is sane on linux.  It should of course be

In case you missed it, I wrote a patch for libscg and posted it here
last week, and as it actually shrinks the code, it would benefit other
systems as well - albeit only by reducing their download size.

> clearly marked as having been changed in such a way.  It should use udev
> if available and HAL and whatever else is appropriate on a modern linux

That my patch doesn't do, but it unifies /dev/sg* and /dev/hd* into one
view (no more ATA:1,2,3, just 1,2,3 will do, as will /dev/hdc or
/dev/sg3).

-- 
Matthias Andree
