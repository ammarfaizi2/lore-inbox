Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWAOUz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWAOUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAOUz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:55:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24725 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750710AbWAOUz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:55:56 -0500
Date: Sun, 15 Jan 2006 21:55:48 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paul Dickson <dickson@permanentmail.com>
cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
Subject: Re: state terminology
In-Reply-To: <20060115130024.0db8fb1c.dickson@permanentmail.com>
Message-ID: <Pine.LNX.4.61.0601152154390.4240@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601142234280.23423@yvahk01.tjqt.qr>
 <200601151058.55369.ioe-lkml@rameria.de> <20060115130024.0db8fb1c.dickson@permanentmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Is there a specific term (other than "hang") associated with this 
>> > situation? It's not a "dead-lock", because there is no other process 
>> > (anymore) which could potentially up the semaphore.
>> 
>> This is a simple "resource leak" (or "semaphore leak" in this case).
>> 
>How about "locked-out" or "lock-out"?  It's akin to a locked room, with
>the keys left inside.

Yeah, comes closer. I also thought about cul-de-sac. (Which does not allow to
proceed further, but let's some waiting process abort.)


Jan Engelhardt
-- 
