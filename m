Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUBVKAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 05:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUBVKAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 05:00:14 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:641 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261216AbUBVKAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 05:00:10 -0500
Date: Sun, 22 Feb 2004 11:00:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
Message-ID: <20040222100008.GA1078@ucw.cz>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org> <20040222025957.GA31813@MAIL.13thfloor.at> <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 07:12:20PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 22 Feb 2004, Herbert Poetzl wrote:
> > 
> > hmm, so the current x86_64 will be changed to x86-64 or
> > will there be x86_64 and x86-64?
> 
> No. The filesystem policy _tends_ to be that dashes and spaces are turned 
> into underscores when used as filenames. Don't ask me why (well, the space 
> part is obvious, since real spaces tend to be a pain to use on the command 
> line, but don't ask me why people tend to conver a dash to an underscore).
> 
> So the real name is (and has always been, as far as I can tell) x86-64. 

As far as I know, the real reason for the underscore in x86_64 in Linux
is that autoconf/configure hate dashes in arch names, because of this
notation:

	x86_64-gnu-linux-pc

If a dash were used, the string would be unparseable without prior
knowledge of all arch names.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
