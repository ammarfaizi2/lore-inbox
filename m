Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUEBQEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUEBQEy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 12:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUEBQEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 12:04:54 -0400
Received: from zork.zork.net ([64.81.246.102]:20936 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263124AbUEBQEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 12:04:53 -0400
To: linux-kernel@vger.kernel.org
Cc: herbert@13thfloor.at
Subject: Re: [RFC] Filesystem with multiple mount-points
References: <Pine.LNX.4.44.0405021508210.834-100000@poirot.grange>
	<Pine.LNX.4.58L0.0405021712280.31153@ahriman.bucharest.roedu.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, herbert@13thfloor.at
Date: Sun, 02 May 2004 17:04:52 +0100
In-Reply-To: <Pine.LNX.4.58L0.0405021712280.31153@ahriman.bucharest.roedu.net> (dizzy@roedu.net's
 message of "Sun, 2 May 2004 17:14:46 +0300 (EEST)")
Message-ID: <6ur7u2izmj.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GNU/Dizzy <dizzy@roedu.net> writes:

> How about mounting the big volume somewhere and using -o bind to mount 
> some paths within it in different places of your needs ? I know that -o 
> bind doesnt honor -o ro yet but if you really needed maybe you can make a 
> patch for that, I for one would be very interested about that.

Herbert Poetzl's bind mount extensions should fit the bill here.
I am unsure of the current status of the patches, though.
