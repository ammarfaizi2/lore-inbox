Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288974AbSAOBWz>; Mon, 14 Jan 2002 20:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289338AbSAOBWq>; Mon, 14 Jan 2002 20:22:46 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:24070 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S288974AbSAOBWd>; Mon, 14 Jan 2002 20:22:33 -0500
Date: Tue, 15 Jan 2002 01:24:36 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020115012436.GA58740@compsoc.man.ac.uk>
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020115005053.GA16892@faceprint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115005053.GA16892@faceprint.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16QIIx-0004q3-00*qri3tEAMT7k* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 07:50:53PM -0500, Nathan Walp wrote:

> She can't very well patch her vendor kernel, because I sincerely doubt
> the patch will apply cleanly, if this driver is such that it needs a
> patch as opposed to just a module.

If it needs a patch, it's messing with kernel internals and she certainly shouldn't
be trying it without an awareness of the potential interactions, or a "recommended
version" from the patch vendor. So if she needs a really stable configuration,
she needs to punt the problem to departmental support.

If it doesn't need a patch, the sensible and proper solution is to autoconfize the
external module source tree, which can adapt itself to different kernels correctly.

autoconfigure of kernel will definitely be useful to e.g. the users we see in
#kernelnewbies, but it is /not/ the right solution for Tilly, Penelope, Dick Dastardly
or any other of the Wacky Races crew Eric is talking about.

regards
john

-- 
"Now why did you have to go and mess up the child's head, so you can get another gold waterbed ?
 You fake-hair contact-wearing liposuction carnival exhibit, listen to my rhyme ..."
