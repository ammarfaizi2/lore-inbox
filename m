Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbTIWRDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTIWRDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:03:54 -0400
Received: from smtp2.fre.skanova.net ([195.67.227.95]:17118 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262080AbTIWRDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:03:52 -0400
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics bk8 + patches
References: <200309221025.59347.gallir@uib.es>
From: Peter Osterlund <petero2@telia.com>
Date: 23 Sep 2003 19:03:44 +0200
In-Reply-To: <200309221025.59347.gallir@uib.es>
Message-ID: <m2isnjl9n3.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> writes:

> Peter,
> 	I just tried your last patches at http://w1.894.telia.com/~u89404340/
> patches/touchpad/2.6.0-test5-bk8/v1/.
> 
> They not only gives the sync's error:
> 
> Synaptics driver lost sync at 4th byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver resynced.
...
> but also the pointer is almost uncontrollable. 
> 
> The pointer's response is not coherent, mainly the speed. Sometimes is 
> slower, other faster, sometimes the mouse even doesn't move, especially 
> in the y axis.
> 
> Also, most of the time a tap is considered a very short drag.

1. I don't know what's causing the lost sync errors. Someone else
   reported that disabling ACPI helped on his computer.

2. Don't apply patch #4 from my web site. It changes the event
   protocol and requires user space changes that I haven't implemented
   yet.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
