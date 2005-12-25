Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVLYVNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVLYVNM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVLYVNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:13:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2002 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750931AbVLYVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:13:10 -0500
Date: Sun, 25 Dec 2005 22:13:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing
In-Reply-To: <43AE2B06.4010906@ums.usu.ru>
Message-ID: <Pine.LNX.4.61.0512252209380.15152@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0512242300360.29877@yvahk01.tjqt.qr>
 <43AE2B06.4010906@ums.usu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Differences between our versions are described below.

What do you think we should do? I have not given this fix any thought, 
because it applied fine for long time (+/- fuzz), so I cannot comment on 
anything in your version being better or not.

> My version of to_utf8() takes uint as a second argument and handles values
> beyonf 0xffff.

I doubt that there is reason to support characters beyond 0xffff.
CJK is within 0xffff, besides that console fonts just do not have the 
capacity to support CJK in a meaningful way.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
