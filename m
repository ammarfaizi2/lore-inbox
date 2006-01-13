Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422854AbWAMTg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422854AbWAMTg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWAMTg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:36:27 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35202 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1422854AbWAMTg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:36:26 -0500
Date: Fri, 13 Jan 2006 11:39:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 01/17] BRIDGE: Fix faulty check in br_stp_recalculate_bridge_id()
Message-ID: <20060113193936.GN3335@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org> <20060113032238.565599000@sorel.sous-sol.org> <200601131946.46782.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601131946.46782.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Oeser (ioe-lkml@rameria.de) wrote:
> Why not include a shorter version of this nice explanation
> above the list_for_each_entry() loop?
> 
> Like:
> 
> /* We try to find the min MAC address to use in this bridge id. */

Send a patch to Stephen ;-)  I'll leave it as is for -stable, since it's
not a candidate for janitorial cleanups.

thanks,
-chris
