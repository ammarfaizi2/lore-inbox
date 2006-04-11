Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDKKfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDKKfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDKKfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:35:11 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:3228 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750715AbWDKKfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:35:09 -0400
Date: Tue, 11 Apr 2006 12:35:06 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Detecting illegal memory access
Message-ID: <Pine.LNX.4.61.0604111230190.928@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I am looking for a way to check from userspace if a given address can be 
dereferenced. One way would be to examine /proc/self/maps if there is 
something mapped and 'r' at the address, but this seems a little time 
consuming. Is there another way? Kernelspace does have it I think, as 
access_ok().


Jan Engelhardt
-- 
