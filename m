Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUJTP3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUJTP3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUJTP2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:28:19 -0400
Received: from adsl-66-141-207-172.dsl.tulsok.swbell.net ([66.141.207.172]:38529
	"EHLO bronco.mcalesterlinux.net") by vger.kernel.org with ESMTP
	id S268028AbUJTPUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:20:46 -0400
Date: Wed, 20 Oct 2004 10:19:39 -0500
From: Harold C King <hcking@mcalesterlinux.net>
To: linux-kernel@vger.kernel.org
Subject: Lost 24 bit color using 2.6.9 and Xorg 6.8.1
Message-Id: <20041020101939.432989c2.hcking@mcalesterlinux.net>
Organization: McAlesterLinux.net
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 24 bit color now fails using Xorg 6.8.1 and the released 2.6.9 kernel.
The video drivers involved werer i810 (and intel_agp).  This was tried on
two different systems with the same results (separate kernel compiles too).
Note, the screen resolution setting doesn't seem to effect the problem.

These systems were running 2.6.8.1 at 24 bit color with no problems.

The error messages in the Xorg.0.log varies, however on one system received:

    space: 63692 wanted 65528

On the other the problem was an X lockup upon ICEWM menu selection, no log entry.


Anyone have an idea how to proceed?

Hal


   

