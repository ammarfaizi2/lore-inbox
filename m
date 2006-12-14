Return-Path: <linux-kernel-owner+w=401wt.eu-S1750724AbWLNDcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWLNDcJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 22:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWLNDcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 22:32:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45356 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbWLNDcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 22:32:08 -0500
Date: Wed, 13 Dec 2006 19:32:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.20-rc1
In-Reply-To: <200612132146.41829.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.64.0612131918100.5718@woody.osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612132146.41829.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Gene Heskett wrote:
>
> Ok, one not so silly Q (IMO) from the resident old fart.  I saw, sometime 
> in the past week, a relatively huge ieee1394 update go by.  And I have 
> some issues with the present 2.6.19 version causeing segfaults and kino 
> go-aways when trying to capture from my firewire movie camera.  Problems 
> occur when trying to control the camera from kino.
> 
> Is this patchset in this -rc1?  If it is, I'll see if I can get a build to 
> work and check it out.

-rc1 does include a reasonably big firewire update, but I'm not sure how 
it will affect your camera usage. In fact, the ieee1394 people seem to be 
trying to deprecate the dv1394 stuff, in favour of just raw1394 and 
user-mode libraries.

I think you can tell Kino to use either the DV or the raw interface, but 
I'm not sure. If you can, try either. The raw interface seems to be 
horribly misdesigned (security problems), but is the one to use.

But by all means, give it a shot, and regardless of whether it works 
better or not, you might want to cry on the shoulder of Stefan Richter 
<stefanr@s5r6.in-berlin.de> about the issues you see.. Of course, please 
talk to the Kino people too (although I have absolutely no idea who they 
would be).

		Linus

