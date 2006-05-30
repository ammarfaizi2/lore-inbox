Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWE3JDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWE3JDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWE3JDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:03:51 -0400
Received: from math.ut.ee ([193.40.36.2]:38556 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932191AbWE3JDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:03:50 -0400
Date: Tue, 30 May 2006 12:03:47 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: prep ppc boot broken post rc5
Message-ID: <Pine.SOC.4.61.0605301159520.15775@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Motorola Powerstack II Pro4000 (a PReP machine from Motorola) does 
not boot in current -git. It worked fine in -rc5 except iptables (not 
tacked down the breaking commit yet, sorry) but does not boot in current 
-git (neither did it with a 2 days old checkout).

The symptoms are that the boot command line is corrupted (parts of 
prompt or previous output are written to command line and the command 
line becomes broken (like invalid root device).

-- 
Meelis Roos (mroos@linux.ee)
