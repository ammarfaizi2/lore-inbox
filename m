Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTEGOw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTEGOw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:52:29 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:39642 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263539AbTEGOw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:52:27 -0400
Date: Wed, 7 May 2003 17:04:29 +0200
From: Torsten Landschoff <torsten@debian.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507150429.GA7248@stargate.galaxy>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507144736.GE8978@holomorphy.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 07:47:36AM -0700, William Lee Irwin III wrote:
> The kernel stack is (in Linux) unswappable memory that persists
> throughout the lifetime of a thread. It's basically how many threads
> you want to be able to cram into a system, and it matters a lot for
> 32-bit.

Okay, that makes sense. BTW: Why not go a step further and have just 
one kernel stack (probably better one per CPU)?

Greetings

	Torsten
