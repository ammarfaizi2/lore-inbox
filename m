Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279547AbRJXMFa>; Wed, 24 Oct 2001 08:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279548AbRJXMFU>; Wed, 24 Oct 2001 08:05:20 -0400
Received: from zeus.kernel.org ([204.152.189.113]:9914 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S279547AbRJXMFE>;
	Wed, 24 Oct 2001 08:05:04 -0400
Date: Wed, 24 Oct 2001 14:00:16 +0200
From: Kurt Roeckx <Q@ping.be>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
Message-ID: <20011024140016.A2467@ping.be>
In-Reply-To: <3BD5AED6.90401C9C@sun.com> <20011024133639.A2225@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011024133639.A2225@ping.be>; from Q@ping.be on Wed, Oct 24, 2001 at 01:36:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 01:36:40PM +0200, Kurt Roeckx wrote:
> On Tue, Oct 23, 2001 at 10:54:30AM -0700, Tim Hockin wrote:
> > So we've noticed, and taken issue with this behavior.
> > 
> > If you have several IP aliases on an interface (eth0:0, eth0:1, eth0:2) you
> > get inconsistent behavior when downing them.
> > 
> > * if I 'ifconfig down' eth0:1, I am left with eth0:0 and eth0:2
> > * if I 'ifconfig down' eth0:0, eth0:1 and eth0:2 go away, too

Oops, I seem to have responded a little too fast.

It used to be, if you ifconfig down eth0:1, that eth0, eth0:2
were gone too.

If you down eth0:0, does eth0 go down too?


Kurt

