Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWDILpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWDILpO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 07:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWDILpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 07:45:14 -0400
Received: from alpha.polcom.net ([83.143.162.52]:29139 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1750733AbWDILpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 07:45:13 -0400
Date: Sun, 9 Apr 2006 13:45:07 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Subject: Slow swapon for big (12GB) swap
Message-ID: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using big swap here (as a backing for potentially huge tmpfs). And I 
wonder why swapon on such big (like 12GB) swap takes about 7 minutes 
(continuous disk IO). Is this expected? Why it is like that? Can I do 
anything to speed it up? Or maybe remove it into the background with low 
priority or something like that?


Thanks in advance,

Grzegorz Kulewski

