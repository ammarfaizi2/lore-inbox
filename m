Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264186AbUEDBTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbUEDBTC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUEDBTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:19:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18870 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264186AbUEDBS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:18:59 -0400
Date: Mon, 3 May 2004 22:19:47 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Julian Bradfield <jcb@inf.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang with 2.4.26 copying to loopback device
Message-ID: <20040504011947.GC8028@logos.cnet>
References: <16534.48421.296794.467014@toolo.inf.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16534.48421.296794.467014@toolo.inf.ed.ac.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 10:44:05PM +0100, Julian Bradfield wrote:
> I'm running a vanilla 2.4.26 kernel (on a rather old distro, Mandrake
> 9.0).
> I have large (6GB) file on a remote NFS server (running 2.4.18), on
> which
> there is a file system that I'm mounting via loopback.
> When I copy to this looped back filesystem, I get a hang after a few
> megabytes. After the copy hangs, I move the cursor around and soon X
> freezes as well. I can, however, reboot via sysrq.
> 
> I've seen several reports a couple of years ago of deadlocks in
> loopback, but nothing recently that I can find via searching.
> Is there anything currently known to be an issue, or should I start
> preparing a proper report?

Please prepare a more complete report with alt+sysrq+p and alt+sysrq+t 
output if possible. Attaching a serial console to the box is 
very helpful if you dont want to copy the output by hand.
