Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbUACVjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUACVjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:39:53 -0500
Received: from defout.telus.net ([199.185.220.240]:62610 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S264104AbUACVjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:39:52 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1073165991.11296.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 03 Jan 2004 14:39:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I've seen this too.  It happens when I run ls -al or ls -alR on an
uncached directory (usually after boot).  If the directory is big, I
wait 3-4 seconds for a listing.  I've updated bash with yum (currently
I'm using bash 2.05b on Fedora with 2.6.1-pre1).  It probably doesn't
help that my drives are slow (5400 rpm).  Doing regression performance
testing on the drives using hdparm helps, but the problem still exists.

