Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTFKWDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTFKWDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:03:47 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:35249 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264555AbTFKWDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:03:46 -0400
Subject: 2.5.70-mm8: freeze after starting X
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 15:17:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded from -mm3 (which I'd been running solidly for over a
week) to -mm8, and find that the system freezes hard after I start the X
server.  After X starts, lifetime varies from zero to maybe 20 seconds
of app launching, then everything locks up.

At this point, the machine is still pingable, but daemons like sshd
don't respond, and I can't see any logs.  After a reboot back to -mm3,
there's nothing suspicious in /var/log.

	<b

