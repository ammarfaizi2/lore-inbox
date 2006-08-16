Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWHPQ0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWHPQ0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWHPQ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:26:47 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:2701 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751143AbWHPQ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:26:46 -0400
Message-ID: <44E34742.80302@lwfinger.net>
Date: Wed, 16 Aug 2006 11:26:42 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: DEBUG_LOCKS_WARN_ON triggered by bcm43xx-SoftMAC
References: <44E296DD.3040803@lwfinger.net> <200608161806.10348.mb@bu3sch.de>
In-Reply-To: <200608161806.10348.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> 
> Hm, weird bug.
> I can't reproduce this on i386 or PPC.
> Could it be a bug in the lockdep code?
> 

It could be. I'll send it on to LKML. Perhaps one of the experts
there can tell us. It doesn't seem to cause any trouble, but I get
one of these when bcm43xx starts.

Are you running WPA? The message seems to occur just after
wpa_supplicant finishes the connection and sets the security flags.

Larry

