Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTKXT4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTKXT4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:56:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:17315 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263700AbTKXT4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:56:35 -0500
Date: Mon, 24 Nov 2003 11:57:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Karl Pitrich <pit@0xff.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LSI53C1030 (Fustion MPT) performance
Message-Id: <20031124115707.38eb0333.akpm@osdl.org>
In-Reply-To: <1069668564.2372.127.camel@warp.fabafsc.fabagl.fabasoft.com>
References: <1069668564.2372.127.camel@warp.fabafsc.fabagl.fabasoft.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl Pitrich <pit@0xff.at> wrote:
>
> hi,
> 
> i got a new ibm intellistation z pro dual xeon (6221-49G) with on board 
> Fusion MPT chipset (LSI53C1030) and fast U160 disks.
> 
> 2.4.20-8 (redhat) and 2.6.0-test9-vanilla 
> (each customer compiled minimal kernels) 
> both yield very poor disk performance.
> 
> i didn't do specific benkchmarking, but mv'ing a 3GB $HOME to another
> partition takes at least 4x the time as on my old P4 workstation with
> IDE drive.
> 
> is poor performance with this controller a known problem?
> could that have to do something with smp?
> 
> in 2.6.0, the driver's cvs-versions seem to match the ones in the
> sources offered by LSI for download.
> lkml-archives and google weren't all too helpful.
> 

The 2.6 driver runs nicely in single-disk mode but has been reported to run
like a dog in RAID mode.  I do not know if the 2.4 driver has the same problem.


