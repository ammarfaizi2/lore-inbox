Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUBNUUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 15:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUBNUUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 15:20:05 -0500
Received: from ssatchell1.pyramid.net ([208.170.252.115]:27614 "EHLO
	ssatchell1.pyramid.net") by vger.kernel.org with ESMTP
	id S263101AbUBNUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 15:20:02 -0500
Subject: Hard drive fault prediction
From: Stephen Satchell <list@satchell.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0310F0B9@stca204a.bus.sc.rolm.com>
References: <7A25937D23A1E64C8E93CB4A50509C2A0310F0B9@stca204a.bus.sc.rolm.com>
Content-Type: text/plain
Message-Id: <1076790000.10391.13.camel@ssatchell1.pyramid.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 12:20:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running into a situation that starting to drive me bats: I'm seeing
more hard disk failures, both in IDE and SCSI drives, and need some way
of knowing when they are starting to go south.  (With appropriate
apologies to the Enzeds and Aussies on the list.)

Are there any drive-independent error counters I can monitor in 2.4 to
be able to detect drive failures early?  I've looked around and have
found some counters in IDE that might help, but without a known failing
drive I don't know if it will tell me much.

I'm looking for a lightway to find failures, so grepping
/var/log/messages is out because it takes too many resources.  I'm
hoping there is something in the /proc file system (or whatever it's
morphing to) that I can examine without taking disk accesses away from
the primary task of the server.

Stephen Satchell


