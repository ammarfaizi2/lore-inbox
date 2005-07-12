Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVGLO4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVGLO4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVGLO4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:56:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31890 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261450AbVGLOzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:55:16 -0400
Date: Tue, 12 Jul 2005 10:58:02 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Tom Zanussi <zanussi@us.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <17107.6290.734560.231978@tut.ibm.com>
Message-ID: <Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
References: <17107.6290.734560.231978@tut.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Jul 2005, Tom Zanussi wrote:

> 
> Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> logging and buffering capability, which does not currently exist in
> the kernel.
> 

One concern I had regarding relayfs, which was raised previously, was 
regarding its use of vmap, 
http://marc.theaimsgroup.com/?l=linux-kernel&m=110755199913216&w=2 On x86, 
the vmap space is at a premium, and this space is reserved over the entire 
lifetime of a 'channel'. Is the use of vmap really critical for 
performance?

thanks,

-Jason
