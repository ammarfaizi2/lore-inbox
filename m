Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWCPUXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWCPUXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWCPUXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:23:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51361 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751266AbWCPUXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:23:06 -0500
Date: Thu, 16 Mar 2006 21:23:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mounting /dev/loop0: Device or resource busy
In-Reply-To: <200603141508.53504.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0603162122160.11776@yvahk01.tjqt.qr>
References: <200603141508.53504.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Why can I mount most block devices multiple times, but when I try to mount a 
>loop device more than once under 2.6.16-rc5 it tells me it's busy?
>
It should be possible to mount a block device multiple times using the 
_same_ filesystem.

>This used to work...

bd_claim() is a starting point.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
