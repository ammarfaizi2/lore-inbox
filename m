Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUEYDjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUEYDjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 23:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUEYDjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 23:39:24 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:39040 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S264514AbUEYDjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 23:39:23 -0400
Date: Mon, 24 May 2004 22:39:14 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: John Rimell <john@rimell.cc>, Sam Gill <samg@seven4sky.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux 2.6.6 completely locked up. : kernel BUG at    
       fs/buffer.c
In-Reply-To: <1144.128.150.143.219.1085152432.squirrel@webmail.seven4sky.com>
Message-ID: <Pine.GSO.4.21.0405242235300.8669-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> May 19 18:44:38 fred smartd[1364]: Device: /dev/hdi, FAILED SMART
> >> self-check. BACK UP DATA NOW!

If this is an old version of smartd, then this MAY be a bogus message, but
if it's not something is seriously wrong with the disk. You can check by
running smartctl: smartctl -a /dev/hdi

If the system is too unstable to boot, so that you can't run the command
above, then you can run smartctl from a bootable CD.

Bruce

