Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbTIATwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTIATwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:52:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53006
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263238AbTIATwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:52:14 -0400
Date: Mon, 1 Sep 2003 12:52:23 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
Message-ID: <20030901195223.GA31760@matchmail.com>
Mail-Followup-To: Matthias Andree <matthias.andree@gmx.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva> <20030831115050.GC30252@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831115050.GC30252@merlin.emma.line.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 01:50:50PM +0200, Matthias Andree wrote:
> On Sat, 30 Aug 2003, Marcelo Tosatti wrote:
> 
> > 05_vm_09_misc_junk-3 removes the PF_MEMDIE and you also seem to remove the
> > OOM killer. Is that right? Why?
> 
> Nuking OOM killer is IMHO a sane thing to do. Unless you start
> everything out of PID #1 which is unkillable, usually init(8), you don't
> want the OOM killer. Imagine it nukes your portmap. With Linux portmap
> that doesn't support warm starts (unlike Solaris 8), this means: reboot.

Can't you just restart the other rpc services after restarting portmap?
(IIRC, I have done exactly this without trobule)
