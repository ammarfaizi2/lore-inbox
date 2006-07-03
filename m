Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWGCG4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWGCG4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWGCG4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:56:30 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:23069 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750889AbWGCG4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:56:30 -0400
Date: Mon, 3 Jul 2006 08:56:28 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch,
       benh@kernel.crashing.org, johannes@sipsolutions.net, stelian@popies.net,
       chainsaw@gentoo.org
Subject: Re: [RFC] Apple Motion Sensor driver
Message-ID: <20060703065628.GA21113@hansmi.ch>
References: <20060702222649.GA13411@hansmi.ch> <20060702201415.791c6eb2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060702201415.791c6eb2.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew

On Sun, Jul 02, 2006 at 08:14:15PM -0700, Andrew Morton wrote:
> On Mon, 3 Jul 2006 00:26:49 +0200
> Michael Hanselmann <linux-kernel@hansmi.ch> wrote:

> > Below you find the latest revision of my AMS driver.

> I was about to merge the below, then this comes along.  Now what?

> From: Stelian Pop <stelian@popies.net>

> This driver provides support for the Apple Motion Sensor (ams), which
> provides an accelerometer and other misc.  data.  Some Apple PowerBooks

I just noticed yesterday that Stelian sent a patch to lkml in May. My
work is based on his separate driver from his website.

Given the fact that my driver includes all of his functionality and that
replacing his with mine later in the process would mean to remove whole
files again, I'd suggest to wait until I've fixed the outstanding issues
(as seen in this thread) and then to merge mine.

Greets,
Michael
