Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbUB1Hyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 02:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbUB1Hyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 02:54:40 -0500
Received: from av1-1-sn3.vrr.skanova.net ([81.228.9.105]:13027 "EHLO
	av1-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262989AbUB1Hyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 02:54:33 -0500
To: Ralph Campbell <ralphc@nikto.sfbay.sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait_queue_t is fundamentally broken; need pthread_cond_t
References: <200402272309.i1RN98bk002304@nikto.sfbay.sun.com>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Feb 2004 08:54:29 +0100
In-Reply-To: <200402272309.i1RN98bk002304@nikto.sfbay.sun.com>
Message-ID: <m2k727myfe.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph Campbell <ralphc@nikto.sfbay.sun.com> writes:

> [1.] One line summary of the problem:    
> 	wait_queue_t is fundamentally broken; need pthread_cond_t
> 
> [2.] Full description of the problem/report:
> 	I hate to be the bearer of bad news but the programming model
> 	for using wait queues is fundamentally broken and should be
> 	replaced with something like pthread_cond_t. Here is an example
> 	taken from chapter 5 of "Linux Device Drivers", 2nd edition,
> 	by Rubini & Corbet:

I suggest you read the "Going to Sleep Without Races" section in
chapter 9 of that book if you want to understand why you are wrong.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
