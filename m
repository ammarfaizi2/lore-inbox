Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTICTjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264249AbTICTiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:38:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:53660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264242AbTICThQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:37:16 -0400
Message-Id: <200309031937.h83JbFL18138@mail.osdl.org>
To: linux-kernel@vger.kernel.org
cc: linstab@lists.osdl.org
Subject: [osdl-aim-7] AS/CFQ/deadline runs 
Date: Wed, 03 Sep 2003 12:37:15 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From OSDL STP, on the 4-cpu platform
OSDL-aim-7 test, using the new_dbase workload. 

AS looks very good, tho i will be repeating for confirmation. 
(Would be happier if both runs were on same machine)
I was told that CFQ is still WIP,
test was already on a machine when i found out, so it's included.


STP id	PLM#	Kernel Name 	Scheduler	MaxJPM	MaxUser	Host	  Change
278804	2084	2.6.0-test4-mm4 deadline 	5289.15	 88	 stp4-002 0.00
278803	2084	2.6.0-test4-mm4 AS 	        5650.16	 96	 stp4-001 +6.82
278805	2084	2.6.0-test4-mm4 CFQ 		5355.73	 88	 stp4-000 +1.25

cliffw

