Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316603AbSE3MMm>; Thu, 30 May 2002 08:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316602AbSE3MMl>; Thu, 30 May 2002 08:12:41 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:58893
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S316603AbSE3MMk>; Thu, 30 May 2002 08:12:40 -0400
Date: Thu, 30 May 2002 14:12:25 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: me@vger.org
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Strange RAID2 behavier...
Message-ID: <20020530141225.A21429@bouton.inet6-interne.fr>
Mail-Followup-To: me@vger.org, linux-kernel@vger.kernel.org,
	Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <Pine.LNX.4.21.0205301353210.16022-100000@kenny.worldonline.se> <Pine.LNX.4.21.0205301435390.20123-100000@kenny.worldonline.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On jeu, mai 30, 2002 at 02:37:53 +0200, me@vger.org wrote:
> I made the md2 a linear raid of one drive, now I can stop the md3.
> This means that for example making md0 and md3 will make md3 unstoppable,
> has this bug already been reported?

This could be a bug/constraint in raidtools as said in mad raidtab:
"the  parsing  code  isn't  overly bright".

I've had small glitches when using comments in raidtab. Try removing all
your commented /dev/md2 related lines instead of building a dumb array.

LB.
