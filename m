Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVCXTtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVCXTtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVCXTts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:49:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24452 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261305AbVCXTrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:47:53 -0500
Date: Thu, 24 Mar 2005 20:47:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
In-Reply-To: <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>
Message-ID: <Pine.LNX.4.61.0503242047000.8883@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
 <200503231740.09572.maillist@zuco.org> <Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
 <20050323174925.GA3272@zero> <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
 <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > There's probably a number of apps that skip the first two dirents, instead
>> > of checking for the dot dirs.
>> Yep, check `-noleaf' in find(1)
>Then it is broken in several ways.  
>First, file systems are not required to implement ".." (only "." is
>magical, ".." is a courtesy).  

Heh, what would happen if .. disappeared? Would `cd ..` become impossible 
(even if it is a shell builtin, it probably stat()s for ..)?


Jan Engelhardt
-- 
