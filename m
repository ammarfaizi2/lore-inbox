Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVCWQOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVCWQOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVCWQOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:14:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34784 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261650AbVCWQOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:14:43 -0500
Date: Wed, 23 Mar 2005 11:14:41 -0500
From: Dave Jones <davej@redhat.com>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050323161441.GA7994@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Giuseppe Bilotta <bilotta78@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <20050314191230.3eb09c37.diegocg@gmail.com> <1110827273.14842.3.camel@mindpipe> <20050323013729.0f5cd319.diegocg@gmail.com> <1111539217.4691.57.camel@mindpipe> <20050323011313.GL15879@redhat.com> <MPG.1cab456fb7b20f93989718@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1cab456fb7b20f93989718@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 09:21:22AM +0100, Giuseppe Bilotta wrote:
 > Dave Jones wrote:
 > > Some of the folks on our desktop team have been doing a bunch of experiments
 > > at getting boot times down, including laying out the blocks in a more
 > > optimal manner, allowing /sbin/readahead to slurp the data off the disk
 > > in one big chunk, and run almost entirely from cache.
 > 
 > What are the cons of using "all of" the RAM at boot time to 
 > cache the boot disk?
 
It's memory that's otherwise unused. Once you start using the system
anything cached will get reclaimed as its needed.

		Dave

