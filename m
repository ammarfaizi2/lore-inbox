Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWDKLah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDKLah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWDKLag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:30:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:60371 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750760AbWDKLae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:30:34 -0400
Date: Tue, 11 Apr 2006 13:30:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Slow swapon for big (12GB) swap
In-Reply-To: <Pine.LNX.4.63.0604101205300.31989@alpha.polcom.net>
Message-ID: <Pine.LNX.4.61.0604111329520.928@yvahk01.tjqt.qr>
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
 <443A0A6F.2040500@aitel.hist.no> <Pine.LNX.4.63.0604101205300.31989@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Well - I use it for /var/tmp for compiling packages in Gentoo. Most compiles
> use < 1MB of it and it is *much* faster that way because immendiate data never
> touch disk. And the disk stays idle the whole time so can be put to sleep and
> should live longer.
>

Spinning the disk up and down more often than a continuously-running disk 
is also a issue.


Jan Engelhardt
-- 
