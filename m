Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267428AbUHDVMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267428AbUHDVMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267432AbUHDVMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:12:45 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:51401 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267428AbUHDVLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:11:49 -0400
Date: Wed, 4 Aug 2004 17:15:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MTRR driver model support broken on SMP.
In-Reply-To: <1091597484.3191.90.camel@laptop.cunninghams>
Message-ID: <Pine.LNX.4.58.0408041712060.19619@montezuma.fsmlabs.com>
References: <1091585241.3303.6.camel@laptop.cunninghams> 
 <Pine.LNX.4.58.0408040119270.19619@montezuma.fsmlabs.com> 
 <1091596967.3189.86.camel@laptop.cunninghams> 
 <Pine.LNX.4.58.0408040128490.19619@montezuma.fsmlabs.com>
 <1091597484.3191.90.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Nigel Cunningham wrote:

> Okay. So the question then is how to get them restored. I don't
> understand much about the driver model, but it seems to me that all we
> should need it get to mtrr save/restore done from the
> drivers_suspend/resume calls, which do have interrupts enabled. But how
> to achieve that...

Indeed, i can't see an easy way without writing it up as a "normal"
driver. It'd be nice if we could avoid adding more infrastructure, i'll
give it some more thought.
