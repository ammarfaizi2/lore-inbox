Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRKYOQR>; Sun, 25 Nov 2001 09:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRKYOQH>; Sun, 25 Nov 2001 09:16:07 -0500
Received: from ns.ithnet.com ([217.64.64.10]:21776 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272818AbRKYOQB>;
	Sun, 25 Nov 2001 09:16:01 -0500
Date: Sun, 25 Nov 2001 15:15:43 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Dominik Kubla <kubla@sciobyte.de>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Linux 2.4.16-pre1
Message-Id: <20011125151543.57a1159c.skraw@ithnet.com>
In-Reply-To: <20011125143449.B5506@duron.intern.kubla.de>
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
	<20011125143449.B5506@duron.intern.kubla.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001 14:34:49 +0100
Dominik Kubla <kubla@sciobyte.de> wrote:

> On Sat, Nov 24, 2001 at 04:39:15PM -0200, Marcelo Tosatti wrote:
> 
> > - Correctly sync inodes in iput()			(Alexander Viro)
> 
> Given the  fact that  this bug  in a presumably  stable linux  kernel is
> getting quite some attention in the media (electronic and otherwise). It
> would be prudent  to get out a  2.4.16 which fixes this  bug right about
> now.

The "problem" effectively arises from _fast_ releasing "stable" versions. I
tend to think there should be a slowdown, not a speedup in stable releases,
just because the weird bugs we saw lately were all found shortly after release.
Maybe it would be a good idea to declare a good-looking pre-version "stable"
after a week delay (for testing) or so, omitting further patches.
I think there is no need to fear "bad" media appearance. It's just what makes
the difference: we try to solve the problem in case one is found _and_ talk
frankly about it. No need to hide.
It isn't really the same as shooting down XP/W2K/NT by type'ing a text-file in
a console-window...

Regards,
Stephan
