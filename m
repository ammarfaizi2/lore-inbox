Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbUJYGML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbUJYGML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbUJYGML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:12:11 -0400
Received: from ozlabs.org ([203.10.76.45]:34693 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261511AbUJYGMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:12:07 -0400
Subject: Re: [RFC/PATCH 0/4] cpus, nodes, and the device model: dynamic cpu
	registration
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, mochel@digitalimplant.org,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <20041024094551.28808.28284.87316@biclops>
References: <20041024094551.28808.28284.87316@biclops>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 16:12:04 +1000
Message-Id: <1098684724.8098.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 03:42 -0600, Nathan Lynch wrote:
> For starters, the current situation is that cpu sysdevs are registered
> from architecture code at boot.  Already we have inconsistencies
> betweeen the arches -- ia64 registers only online cpus, ppc64
> registers all "possible" cpus.

Um, how does ia64 bring up a new CPU without
a /sys/devices/system/cpu/cpuX/online?

I have no problem with unification, though.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

