Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTKZJ3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 04:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTKZJ3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 04:29:36 -0500
Received: from bay2-f65.bay2.hotmail.com ([65.54.247.65]:14087 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264108AbTKZJ3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 04:29:34 -0500
X-Originating-IP: [212.143.73.102]
X-Originating-Email: [yuval_yeret@hotmail.com]
From: "yuval yeret" <yuval_yeret@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-18 size-4096 memory leaks
Date: Wed, 26 Nov 2003 11:29:33 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F65DwLK4adtttY00010f98@hotmail.com>
X-OriginalArrivalTime: 26 Nov 2003 09:29:34.0089 (UTC) FILETIME=[CD6B2790:01C3B3FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a constant leak in size-4096 on a machine running 2.4.20-18 SMP 
BIGMEM, which might / might not be related to the machine finally going out 
of memory and going into a hang.

I saw a discussion around similar problems in 2.6.0 (2.6.0-test5/6 (and 
probably 7 too) size-4096 memory leak - http://lkml.org/lkml/2003/10/17/5 )
and an ext3 patch was suggested by Andrew Morton.

>From a brief look the code in 2.4 it seems like the patch might be relevant 
here as well. Is the size-4096 leak a known issue for 2.4 ?
Is the 2.6 patch applicable in 2.4 as well ?


Thanks,

--
Yuval Yeret
Yuval at exanet dot com
Exanet
http://www.exanet.com

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

