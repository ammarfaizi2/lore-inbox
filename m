Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbWAHHyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbWAHHyV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbWAHHyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:54:21 -0500
Received: from ozlabs.org ([203.10.76.45]:18409 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030491AbWAHHyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:54:20 -0500
Date: Sun, 8 Jan 2006 18:43:57 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Joel Schopp <jschopp@austin.ibm.com>, jes@trained-monkey.org,
       rmk+lkml@arm.linux.org.uk, hch@infradead.org,
       linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org,
       viro@ftp.linux.org.uk, linuxppc64-dev@ozlabs.org, mingo@elte.hu,
       nico@cam.org, oleg@tv-sign.ru, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org
Subject: Re: PowerPC fastpaths for mutex subsystem
Message-ID: <20060108074356.GM26499@krispykreme>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net> <43BFFF1D.7030007@austin.ibm.com> <20060107143722.25afd85d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107143722.25afd85d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Doens't this mean that the sped-up mutexes are still slower than semaphores?

Wasnt most of the x86 mutex gain a result of going from fair to unfair
operation? The current ppc64 semaphores are unfair.

Anton
