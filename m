Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271228AbTGWTVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271235AbTGWTSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:18:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43025
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271233AbTGWTRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:17:42 -0400
Date: Wed, 23 Jul 2003 12:32:47 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: different behaviour with badblocks on 2.6.0-test1-mm1-07int
Message-ID: <20030723193247.GI1176@matchmail.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030722214253.GD1176@matchmail.com> <20030723081844.GB1324@home.woodlands> <200307231324.h6NDO5qj009710@turing-police.cc.vt.edu> <20030723151950.GA2218@home.woodlands> <20030723170107.GH1176@matchmail.com> <20030723190929.GB1288@home.woodlands>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723190929.GB1288@home.woodlands>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 12:39:29AM +0530, Apurva Mehta wrote:
> * Mike Fedyk <mfedyk@matchmail.com> [2003-07-23 22:41]:
> > > I am using 2.1.14.. Still no luck with it reading disks.. 
> > 
> > Maybe you need to mount sysfs on /sys?
> 
> Right, gkrellm does report some disk usage now, but it is far from
> accurate. It registers barely any of the disk activity. Starting
> Firebird or Opera may occasionally register one spike on the
> graph. Mostly, the disk activity is not reported. 
> 
> This seems to be a gkrellm bug since vmstat reports disk usage more
> accurately, although I haven't really looked closely at the output..

Ok let's forget about gkrellm because I see similar numbers in vmstat.

Now, let's get back to the origional issue, which is "Why the fuck is
badblocks reading when it should only be writing, and why does it only
happen on a 2.6-test kernel?!!"
