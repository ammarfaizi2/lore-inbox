Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264111AbTCXF2H>; Mon, 24 Mar 2003 00:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264113AbTCXF2H>; Mon, 24 Mar 2003 00:28:07 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:10460 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S264111AbTCXF2G>;
	Mon, 24 Mar 2003 00:28:06 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.65-mm3,4 with contest
Date: Mon, 24 Mar 2003 16:39:11 +1100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303241639.11728.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anticipatory scheduler tested...
no significant difference from 2.5.65-mm2

CFQ scheduler shows some fluctuations in results. At first I thought it was a 
mem leak because they were getting longer, but then they decreased again. 
Results are not consistent enough to give meaningful benchmark results at the 
moment.  Still trying to track down what happened.

The only thing I can say with certainty is read load is faster than the AS 
(108 seconds v 122), and mem load is a little faster (98 v 102).

Con
