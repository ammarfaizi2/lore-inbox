Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSDXJXS>; Wed, 24 Apr 2002 05:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSDXJXR>; Wed, 24 Apr 2002 05:23:17 -0400
Received: from dsl-213-023-038-128.arcor-ip.net ([213.23.38.128]:57514 "EHLO
	starship") by vger.kernel.org with ESMTP id <S310224AbSDXJXQ>;
	Wed, 24 Apr 2002 05:23:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "J.A. Magallon" <jamagallon@able.es>, m.knoblauch@TeraPort.de
Subject: Re: XFS in the main kernel
Date: Tue, 23 Apr 2002 11:23:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Stephen Lord <lord@sgi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3CC56355.E5086E46@TeraPort.de> <3CC581F5.2FBEA0C1@TeraPort.de> <20020423213750.GA1704@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16zwWW-0002Mi-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 April 2002 23:37, J.A. Magallon wrote:
> On 2002.04.23 Martin Knoblauch wrote:
> If XFS is so good (i do not doubt it), I see some issues (plz correct me
> if I'm wrong...):
> 
> - XFS needs substantial changes in the VFS layer to work
> - This changes are good (or make xfs so good)
> - *THE THING* to do is to integrate this changes in mainline tree VFS,
>   so XFS will stop duplicating half the kernel code.
> 
> Why those features are not merged ? Incompatibilities ? Licensing ?
> Religious wars about some way of doing things ?

No.  It's simply a matter of nobody having done the required analysis to
find a really good way to reconcile XFS's way of doing things with
mainline vfs.  This is time-consuming work that requires a good deal of
skill, and right now there are many projects in the same category.

My advice to anyone who wants to make it go faster?  Jump in and start
doing the analysis (start with xfs/pagebuf.c).  If you are a company who
wants it to go faster, try offering money.  Otherwise, it goes at its own
speed, and this work will likely come up to the top of the pile later in
the 2.5 cycle.

-- 
Daniel
