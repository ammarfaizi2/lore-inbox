Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUA2ShN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 13:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUA2ShN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 13:37:13 -0500
Received: from bay1-f96.bay1.hotmail.com ([65.54.245.96]:25094 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266252AbUA2ShJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 13:37:09 -0500
X-Originating-IP: [169.204.239.122]
X-Originating-Email: [highwind747@hotmail.com]
From: "raymond jennings" <highwind747@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: FW: [ERR] [IDEA] - run-length compaction of block numbers
Date: Thu, 29 Jan 2004 10:37:06 -0800
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_5168_7250_65d1"
Message-ID: <BAY1-F96zCI50hUlhuv000153ab@hotmail.com>
X-OriginalArrivalTime: 29 Jan 2004 18:37:06.0954 (UTC) FILETIME=[E5B086A0:01C3E696]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_5168_7250_65d1
Content-Type: text/plain; format=flowed




>From: postmaster@kornet.net
>To: highwind747@hotmail.com
>Subject: [ERR] [IDEA] - run-length compaction of block numbers
>Date: Wed, 21 Jan 2004 20:03:17 +0900
>
>Transmit Report:
>
>  To: pupuru@kornet.net, 452 Requested action not taken: insufficient 
>system storage.[28,-1,41]

_________________________________________________________________
Check out the new MSN 9 Dial-up — fast & reliable Internet access with prime 
features! http://join.msn.com/?pgmarket=en-us&page=dialup/home&ST=1

------=_NextPart_000_5168_7250_65d1
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

Received: from 211.48.62.166 (211.48.62.166) 
	at KTMAIL with ESMTP Hanmir
	by ppp5;Wed, 21 Jan 2004 20:03:17 +0900
X-MsgID: 1074682997179055492.1.ppp5
Message-ID: <1074682997179055492.1.ppp5@ppp5>
Received: from [67.72.78.212] (linux-kernel-owner+pupuru=40kornet.net@vger.kernel.org) by 
          relay6.kornet.net (Terrace MailWatcher) 
          with ESMTP id 2004012119:38:24:911785.6463.10095
          for <pupuru@kornet.net>; 
          Wed, 21 Jan 2004 19:38:18 +0900 (KST) 
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUAPTjE (ORCPT <rfc822;pupuru@kornet.net>);
	Fri, 16 Jan 2004 14:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUAPTjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:39:04 -0500
Received: from bay1-f117.bay1.hotmail.com ([65.54.245.117]:8714 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265726AbUAPTjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:39:01 -0500
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 16 Jan 2004 11:38:59 -0800
Received: from 66.96.64.38 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 16 Jan 2004 19:38:59 GMT
X-Originating-IP: [66.96.64.38]
X-Originating-Email: [highwind747@hotmail.com]
X-Sender: highwind747@hotmail.com
From: "raymond jennings" <highwind747@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [IDEA] - run-length compaction of block numbers
Date: Fri, 16 Jan 2004 11:38:59 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Y-Message-ID: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com>
X-OriginalArrivalTime: 16 Jan 2004 19:38:59.0969 (UTC) FILETIME=[6372E710:01C3DC68]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any value in creating a new filesystem that encodes long contiguous 
blocks as a single block run instead of multiple block numbers?  A long file 
may use only a few block runs instead of many block numbers if there is 
little fragmentation (usually the case).  Also dynamic allocation of 
inodes...etc.  The details are long; anyone interested can e-mail me 
privately.

_________________________________________________________________
Rethink your business approach for the new year with the helpful tips here. 
http://special.msn.com/bcentral/prep04.armx

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



------=_NextPart_000_5168_7250_65d1--
