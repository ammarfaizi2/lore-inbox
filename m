Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVI1FPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVI1FPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 01:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVI1FPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 01:15:19 -0400
Received: from illhyd-static-203.197.252.75.vsnl.net.in ([203.197.252.75]:29891
	"EHLO lexus.moschip.com") by vger.kernel.org with ESMTP
	id S1030190AbVI1FPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 01:15:18 -0400
From: "Eshwar" <eshwar@moschip.com>
To: <linux-kernel@vger.kernel.org>, <d_eshwar_in@yahoo.com>
Subject: TCP Network performance degade from 2.4.18 to 2.6.10
Date: Wed, 28 Sep 2005 10:42:22 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Thread-Index: AcWR5JUZvpGxjSdlT7qfVw0dSJ2DbAyBLgKg
In-Reply-To: <20050726130329.GA3215@ucw.cz>
Message-ID: <LEXUSAX3cf3ednHM3SO00000be8@lexus.moschip.com>
X-OriginalArrivalTime: 28 Sep 2005 05:14:47.0593 (UTC) FILETIME=[8B8CF990:01C5C3EB]
X-TM-AS-Product-Ver: SMEX-7.0.0.1345-3.5.1048-13987.000
X-TM-AS-Result: No-0.200000-4.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all,

I observed there is huge network performance drop from linux 2.4 to 2.6 with
the same setup (No hardware changes..). The results are taken in PIV
processor with D-Link network card... with iperf ... Can some body help me
why such a huge difference... in TCP stream... 

In linux 2.4 (Redhat 9)

DLink	
    TCP              UDP
Tx       94.3Mbps    Tx               95 Mbps
Rx       94.2 Mbps   Rx               95 Mbps

In linux 2.6.10 (Fedora Core 4)
DLink	
	 TCP                     UDP
Tx       64.3 Mbps 	Tx               87 Mbps
Rx       88.1 Mbps      Rx               95 Mbps


Thanks & Regards
Eshwar

