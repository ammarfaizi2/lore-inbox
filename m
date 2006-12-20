Return-Path: <linux-kernel-owner+w=401wt.eu-S1030386AbWLTWTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWLTWTu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWLTWTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:19:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65389 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030379AbWLTWTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:19:47 -0500
Date: Wed, 20 Dec 2006 17:19:46 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
In-reply-to: <86vek6z0k2.fsf@blue.stonehenge.com>
X-X-Sender: nico@xanadu.home
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0612201716270.18171@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
 <86vek6z0k2.fsf@blue.stonehenge.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, Randal L. Schwartz wrote:

> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> 
> Junio> * The 'master' branch has these since the last announcement.
> Junio>   They are NOT in 1.4.4.3.
> 
> Junio>       index-pack usage of mmap() is unacceptably slower on many OSes
> Junio>          other than Linux
> 
> Is this really in master?  I'm still seeing one-hour times on
> my Mac, using 8336afa563fbeff35e531396273065161181f04c.

It is in current master, but not in 8336afa563fbeff35e5313...

To be sure you have it just open index-pack.c and make sure "mmap" is 
not found there anymore.


Nicolas
