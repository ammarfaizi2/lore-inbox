Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTIQFJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTIQFJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:09:58 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:41968 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S262018AbTIQFJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:09:56 -0400
Date: Wed, 17 Sep 2003 01:09:50 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-testX - strange scheduling(?) problem
Message-ID: <20030917050950.GC1376@Master>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P4 2G
1G PC2700 RAM
GF2 GTS video (nv drivers, not nvidia)

In all 2.6.0-test versions (1-5) I get very odd issues when using cpu+memory
intense apps. Using POV-Ray 3.5, for example:
When I render an image I get about 15k pixels per second and the system is
usable and responsive in other apps, most of the time.
About 20% of the time the pixels-per-second is only 3k, the system is at
nearly a standstill, and other apps barely function.
I've tested it many times using the exact same image and the behavior is
very consistent. Other apps do the same, but since I can't get a consistent
starting state with them, I used POV-Ray for the testing.
The slowdown is so bad that the screen can take as long as 2 seconds to 
refresh, opening a term can take as much as 15 seconds.
Stopping the render and restarting it fixes it about 1/2 the time. Stopping
the render and switching to another app, then restarting the render fixes
it about 1/2 the time. Enough stop & restarts always fixes it eventually.
There doesn't appear to be any memory leakage, and the system isn't going
into swap. Top shows the same numbers in all cases. Time of day, other 
apps running, etc. makes no difference.

-- 
Murray J. Root

