Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUFBQhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUFBQhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUFBQhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:37:36 -0400
Received: from main.gmane.org ([80.91.224.249]:30639 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263565AbUFBQh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:37:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Calvin Spealman <calvin@ironfroggy.com>
Subject: Possible bug: ext3 misreporting filesystem usage
Date: Wed, 02 Jun 2004 12:31:41 +0000
Message-ID: <1275157.LnyMtzroWT@ironfroggy.com>
Reply-To: calvin@ironfroggy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-069-132-046-251.carolina.rr.com
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting a possible bug after running my system a few weeks. The
ext3 partition's usage is being misreported. Right now, df -h says ive got
no space left, but according to du /, I'm only using 17 gigs of my 40 gig
drive. Restarting fixes the problem, so I'm thinking it might be some
mis-handled variable in memory, not something on the disc itself? And, yes,
I do know that du is right, not df, because I keep good track of my disc
usage. This is pretty serious, it killed a 40+ hour process that i'll have
to start over again from the beginning!

