Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWDDVY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWDDVY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWDDVY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:24:59 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:23818 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750895AbWDDVY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:24:58 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Mike Hearn <mike@plan99.net>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <4431A93A.2010702@plan99.net>
	<Pine.LNX.4.61.0604041752070.14611@yvahk01.tjqt.qr>
From: Nix <nix@esperi.org.uk>
X-Emacs: because editing your files should be a traumatic experience.
Date: Tue, 04 Apr 2006 22:24:44 +0100
In-Reply-To: <Pine.LNX.4.61.0604041752070.14611@yvahk01.tjqt.qr> (Jan
 Engelhardt's message of "4 Apr 2006 16:54:57 +0100")
Message-ID: <87y7ylrq3n.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Apr 2006, Jan Engelhardt whispered secretively:
> No objections. We'll see what it can buy us, when we get the chance 
> to use it. If it sucks, it will find its way out again. :)

In my experience, if it sucks, it'll be part of the ABI and can't be
removed without breaking userspace code (to wit, /proc/{pid}/smaps,
whose only likely widespread user has declared it too horribly-formatted
to use (i.e. acahalan and procps), but it's still there...)

Stuff in /proc/{pid}/ doesn't die easily...

-- 
`Come now, you should know that whenever you plan the duration of your
 unplanned downtime, you should add in padding for random management
 freakouts.'
