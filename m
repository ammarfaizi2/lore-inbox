Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbTEGUV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTEGUV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:21:28 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:31721 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S263992AbTEGUV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:21:27 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: QUESTION: 2.5 adds 1 to systats even for non I/O operations
Date: Wed, 7 May 2003 22:34:00 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305072234.00733.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working in a daemon to control cpufreq and devices 
(http://freshmeat.net/projects/cpudyn/)

I've just noticed that kernel 2.5 always add one (1) to /proc/diskstats 
and /sys/block/hdX/stat "reads" field for ioctl's requests that don't 
generate data I/O. 

For example for checking the status of the disk (standby, active, sleep) 
or putting the disk in standby.

Is that correct? Do I have to take it in account always?

Thanks in advance.

-- 
  ricardo galli       GPG id C8114D34
