Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265893AbUFDWSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbUFDWSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266032AbUFDWSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:18:41 -0400
Received: from zero.aec.at ([193.170.194.10]:41223 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265893AbUFDWSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:18:39 -0400
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.7-rc2-mm2: system reboot at kernel init on a dual
 Opteron
References: <23v36-Hc-35@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 05 Jun 2004 00:18:22 +0200
In-Reply-To: <23v36-Hc-35@gated-at.bofh.it> (R. J. Wysocki's message of
 "Sat, 05 Jun 2004 00:10:12 +0200")
Message-ID: <m3llj3ezm9.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> writes:

> The 2.6.7-rc2-mm2 reboots my dual Opteron system as soon as it's loaded.  
> There's no any serial console output available, and the hardware environment 
> log is attached.

What does the serial console print when you boot with
earlyprintk=serial,ttySx,baud  ? 

Also I assume -rc2 without -mm works, right?

-Andi

