Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVCXHS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVCXHS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVCXHSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:18:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32955 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263072AbVCXHSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:18:44 -0500
Date: Thu, 24 Mar 2005 08:18:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David McCullough <davidm@snapgear.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: API for true Random Number Generators to add entropy (2.6.11)
In-Reply-To: <20050324044621.GC3124@beast>
Message-ID: <Pine.LNX.4.61.0503240815120.24256@yvahk01.tjqt.qr>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
 <20050324043300.GA2621@havoc.gtf.org> <20050324044621.GC3124@beast>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Would you suggest making /dev/random point to /dev/hw_random then ?

No. I for example do not have a hardware RNG, so `modprobe hw_random` fails 
with No Such Device. Making it a symlink would make it a dangling one.


Jan Engelhardt
-- 
