Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271816AbTHDPmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271818AbTHDPmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:42:14 -0400
Received: from mx01.netapp.com ([198.95.226.53]:11724 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S271816AbTHDPmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:42:14 -0400
From: Brian Pawlowski <beepy@netapp.com>
Message-Id: <200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com>
Subject: Re: FS: hardlinks on directories
In-Reply-To: <20030804134415.GA4454@win.tue.nl> from Andries Brouwer at "Aug 4, 3 03:44:15 pm"
To: aebr@win.tue.nl (Andries Brouwer)
Date: Mon, 4 Aug 2003 08:42:09 -0700 (PDT)
Cc: skraw@ithnet.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME++ PL40 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still waking up, but '..' obviously breaks the "no cycle"
observations.

It's just that '..' is well known name by utilities as opposed
to arbitrary links. Symlinks as poor man's link can create unwanted
cycles (but are caught again by utils?)

I was always wondering what to do with all those spare CPU cycles,
running around in circles in the file system will soak them up. :-)

