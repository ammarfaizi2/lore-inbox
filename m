Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWGHBtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWGHBtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 21:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWGHBtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 21:49:31 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:39408 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751297AbWGHBta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 21:49:30 -0400
Message-ID: <001001c6a231$cef0c2a0$0201a8c0@OFFICEPC>
From: "Accu-Tech" <Accu-Tech@Comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: lock-free rcu-based ref-counting patent applications...
Date: Fri, 7 Jul 2006 18:57:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody know if there are any patent applications for any of the
"existing" RCU-based reference counting techniques? In particular, any
counting algorithms that have fine granularity and do not use any atomic-ops
and/or membars... The existing RCU counting implementations that I have seen
use a per-object counter adjusted with CAS/membar, or actually defer count
adjustments until after sync epoch (rcu-grace)... Pretty expensive imho...

The reason I ask is because I have a patent application out on another
technique that gets around SMR's atomic-ops/membars and most of the caveats
that come along with RCU read-side "critical-regions"... I was just
wondering if anybody might be working on something similar... I remember
scouring through RCU/SMR-based ref-counting patents and applications during 
the
patent-feasibility study I did a couple of years ago... I did find anything
that was similar to my technique... 

