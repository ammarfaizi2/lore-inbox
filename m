Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTFKWVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTFKWVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:21:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21747 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264601AbTFKWVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:21:10 -0400
Subject: Re: 2.5.70-mm8: freeze after starting X
From: Robert Love <rml@tech9.net>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain
Message-Id: <1055370984.672.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jun 2003 15:36:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 15:17, Bryan O'Sullivan wrote:
> I just upgraded from -mm3 (which I'd been running solidly for over a
> week) to -mm8, and find that the system freezes hard after I start the X
> server.  After X starts, lifetime varies from zero to maybe 20 seconds
> of app launching, then everything locks up.
> 
> At this point, the machine is still pingable, but daemons like sshd
> don't respond, and I can't see any logs.  After a reboot back to -mm3,
> there's nothing suspicious in /var/log.

Same problem here. It started happening in -mm6.

I have not narrowed it down to anything suspicious, and because it is in
X and my normal desktop machine I have not really debugged the issue.

Interrupts are still on, though...

	Robert Love

