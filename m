Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbTD1XWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbTD1XWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:22:06 -0400
Received: from uswest-dsl-142-38.cortland.com ([209.162.142.38]:2572 "HELO
	warez.scriptkiddie.org") by vger.kernel.org with SMTP
	id S261387AbTD1XWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:22:05 -0400
Date: Mon, 28 Apr 2003 16:34:21 -0700 (PDT)
From: Lamont Granquist <lamont@scriptkiddie.org>
X-X-Sender: lamont@uswest-dsl-142-38.cortland.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SIGRTMIN, F_SETOWN(-getpgrp()) and threads
In-Reply-To: <1049803162.8113.18.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <20030428162800.D83397-100000@uswest-dsl-142-38.cortland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm attempting to send SIGRTMIN to an entire pgrp composed of threads.
I'm running into issues with the management thread getting this signal and
dying because it is uncaught in that thread.  Is there any way to make the
management thread ignore this signal?  (and i'm running linux 2.4.20-ish
and glibc-2.2.4-19.3)

