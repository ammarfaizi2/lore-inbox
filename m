Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVCWRcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVCWRcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVCWRcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:32:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15327 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262776AbVCWRb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:31:27 -0500
Date: Wed, 23 Mar 2005 18:31:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pietro Zuco <maillist@zuco.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
In-Reply-To: <200503231740.09572.maillist@zuco.org>
Message-ID: <Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
 <200503231740.09572.maillist@zuco.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I agree with Jan.
>The . / .. will be useful for some scripts that use it.

Which scripts use that? As stated, these two directory entries exist when you 
stat() them, they just do not show up in readdir(), and I bet few programs 
care for "." and ".." when doing their readdir.


Jan Engelhardt
-- 
