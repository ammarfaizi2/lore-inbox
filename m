Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278408AbRJXAUQ>; Tue, 23 Oct 2001 20:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278416AbRJXAUG>; Tue, 23 Oct 2001 20:20:06 -0400
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:10259 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S278408AbRJXATy>;
	Tue, 23 Oct 2001 20:19:54 -0400
Date: Wed, 24 Oct 2001 02:20:23 +0200
From: Werner Almesberger <wa@almesberger.net>
To: Eric <ebrower@usa.net>
Cc: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: [Q] pivot_root and initrd
Message-ID: <20011024022023.B8463@almesberger.net>
In-Reply-To: <p05100328b7fb8dcb9473@[207.213.214.37]> <3BD5E71F.6090506@usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BD5E71F.6090506@usa.net>; from ebrower@usa.net on Tue, Oct 23, 2001 at 02:54:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> Both the pivot_root(8) manpage and the <linux>/Documentation/initrd.txt 
> document admonish us to do much more than shown below (chroot, relative 
> pathing of pivot_root arguments, etc).

Correct, yes. Peter's procedure should work with the current
implementation, but it's safer to use the documented approach,
particularly if the solution is distributed to other people.

I currently don't have any plans for changing the pivot_root
implementation, but I wouldn't be surprised if something comes
up at some point in 2.5, since the overall boot architecture
needs a bit of work.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/
