Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWJUV1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWJUV1K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWJUV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 17:27:10 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:26671 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1161026AbWJUV1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 17:27:08 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
X-Message-Flag: Warning: May contain useful information
References: <4537EB67.8030208@drzeus.cx>
	<Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
	<adabqo5lip8.fsf@cisco.com> <453A63A4.4070506@drzeus.cx>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 21 Oct 2006 14:27:05 -0700
In-Reply-To: <453A63A4.4070506@drzeus.cx> (Pierre Ossman's message of "Sat, 21 Oct 2006 20:15:00 +0200")
Message-ID: <ada7iytl5qu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Oct 2006 21:27:07.0089 (UTC) FILETIME=[A8E09C10:01C6F557]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I've actually been using StGIT up until now. But I've started to feel a
 > need for sharing my tree, and StGIT isn't really suited for that.
 > 
 > How have you handled collaborative development on stuff that isn't ready
 > for Linus yet? Simply sending patches back and forth?

I don't use StGIT for collaborative development.  My StGIT branches
are really just patch queues (as the names for-2.6.19 and for-2.6.20
imply).  Usually development is just about done before things wind up
in a maintainer tree, so being able to apply updates to patches
already in my tree is more important than fully automated merged (as
native git gives you).
