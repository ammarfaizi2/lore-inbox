Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUESLTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUESLTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUESLTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:19:12 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:59409 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S263679AbUESLM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:12:28 -0400
From: Meelis Roos <mroos@linux.ee>
To: lkml@kcore.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] eepro100 vs e100?
In-Reply-To: <200405190858.44632.lkml@kcore.org>
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.6 (i686))
Message-Id: <E1BQOzg-00020H-LV@rhn.tartu-labor>
Date: Wed, 19 May 2004 14:12:16 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JDL> I'm wondering what driver is the "best" one to use? Judging by the comments in 
JDL> the files, the e100 driver seems to be the best maintained, though I'm 
JDL> probably wrong ;p

I would suggest e100 from practice. The onboard Ethernet of Intel
D815EEA2 mainboard works fine in 100Mb/FD with both drivers but started
acting strangely in 10Mb/HD network with eepro100 (e100 seems to be OK).

-- 
Meelis Roos
