Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTJKNhI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 09:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTJKNhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 09:37:08 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:65233 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263285AbTJKNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 09:37:06 -0400
Date: Sat, 11 Oct 2003 09:31:14 -0400
From: Ben Collins <bcollins@debian.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: John Mock <kd6pag@qsl.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: slab corruption of hpsb_packet from ohci1394 + sbp2 on 2.6.0-test7
Message-ID: <20031011133114.GW552@phunnypharm.org>
References: <E1A86t4-0001rj-00@penngrove.fdns.net> <Pine.LNX.4.53.0310102125580.15705@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0310102125580.15705@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any clues on how to track this problem down would be greatly appreciated!
> > (Please CC: such replies, as i'm reading via WWW rather than subscribing.)
> 
> The state change synchronization is rather weird in that driver, then 
> there is the whole double semaphore acquisition business which i'm not 
> quite sure of. It looks better suited to a struct completion, but that is 
> the source of your problem. This would be better handled by the 
> maintainer.

FYI, the semaphore is being removed and things are better handled now.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
