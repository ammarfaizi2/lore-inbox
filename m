Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVFHVeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVFHVeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVFHVeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:34:07 -0400
Received: from polyester.arl.wustl.edu ([128.252.153.32]:50898 "EHLO
	polyester.arl.wustl.edu") by vger.kernel.org with ESMTP
	id S261999AbVFHVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:34:04 -0400
Date: Wed, 8 Jun 2005 16:33:34 -0500 (CDT)
From: Manfred Georg <mgeorg@arl.wustl.edu>
To: Alexander Nyberg <alexn@telia.com>
cc: Chris Wright <chrisw@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities not inherited
In-Reply-To: <1118265642.969.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0506081627170.11409@polyester.arl.wustl.edu>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu> 
 <20050608204430.GC9153@shell0.pdx.osdl.net> <1118265642.969.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Jun 2005, Alexander Nyberg wrote:
> btw since the last discussion was about not changing the existing
> interface and thus exposing security flaws, what about introducing
> another prctrl that says maybe PRCTRL_ACROSS_EXECVE?

Wasn't the original inherited set supposed take care of that?

> Any new user-space applications must understand the implications of
> using it so it's safe in that aspect. Yes?

As far as I can tell, applying the patch from the earlier discussion
and setting the inherited set has the same, "I really meant to do this"
effect as what you propose.

> (yeah it's rather silly since there already is an unused
> keep_capabilities flag but that would change old interfaces so ok)

Isn't the keep_capabilities flag related to setuid() ? or did I miss
something.

Manfred
