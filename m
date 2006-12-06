Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759771AbWLFC7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759771AbWLFC7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 21:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759775AbWLFC7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 21:59:49 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46050 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759676AbWLFC7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 21:59:48 -0500
Date: Wed, 6 Dec 2006 03:59:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612060348150.1868@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Andrew Morton wrote:

> [dyntick]
> 
>  Shall merge, I guess.  My confidence is low, but it's Kconfigurable and it
>  needs to get sorted out.

IMO it least at needs one more iteration to address the comments that 
were made (not just mine), in the short term the less it touches 
unconditionally the less I care right now.
In the long term IMO this might need a major rework, the basic problem I 
have is that I don't see how this usable beyond dynticks/hrtimer, e.g. how 
to dynamically manage multiple timer.

bye, Roman
