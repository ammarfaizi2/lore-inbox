Return-Path: <linux-kernel-owner+w=401wt.eu-S932457AbXAIWWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbXAIWWh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbXAIWWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:22:37 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:58228 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932457AbXAIWWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:22:35 -0500
Date: Tue, 9 Jan 2007 23:02:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Shaya Potter <spotter@cs.columbia.edu>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Jan Kara <jack@suse.cz>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
In-Reply-To: <1168360893.5024.38.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0701092301170.4779@yvahk01.tjqt.qr>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> 
 <1168229596875-git-send-email-jsipek@cs.sunysb.edu>  <20070108111852.ee156a90.akpm@osdl.org>
  <20070108231524.GA1269@filer.fsl.cs.sunysb.edu>  <20070109121552.GA1260@atrey.karlin.mff.cuni.cz>
  <1168360219.6054.14.camel@lade.trondhjem.org> <1168360893.5024.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 9 2007 11:41, Shaya Potter wrote:
>
>Again, what about fibre channel support?  Imagine I have multiple blades
>connected to a SAN.  For whatever reason I format the san w/ ext3 (I've
>actually done this when we didn't need sharing, just needed a huge disk,
>for instance for doing benchmarks where I needed a large data set that
>was bigger than the 40GB disk that the blades came with).  I better not
>touch that disk from any of the other blades.

Except probably for the shared partition table, there should not be a
problem if you mount sda1 on one blade, sda2 on another, etc. Or use
something like GFS2 if you want sharing ;-)


	-`J'
-- 
