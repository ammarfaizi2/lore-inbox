Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbWJBHAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWJBHAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 03:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWJBHAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 03:00:21 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:6590 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S932701AbWJBHAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 03:00:20 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Huang <jesse@icplus.com.tw>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 1/5] remove TxStartThresh and RxEarlyThresh
X-Message-Flag: Warning: May contain useful information
References: <1159813431.2576.0.camel@localhost.localdomain>
	<20061001235312.aa2c6d17.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 02 Oct 2006 00:00:18 -0700
In-Reply-To: <20061001235312.aa2c6d17.akpm@osdl.org> (Andrew Morton's message of "Sun, 1 Oct 2006 23:53:12 -0700")
Message-ID: <ada3ba7xkvx.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Oct 2006 07:00:19.0480 (UTC) FILETIME=[6C140180:01C6E5F0]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > For pattern issue need to remove TxStartThresh and RxEarlyThresh.

 > Please describe this issue more completely.
 > 
 > What are the implications of simply removing this feature?  Presumably that
 > code was there for a reason..

Actually I think this patch needs to be handled delicately -- because
based on earlier emails from Jesse (http://www.mail-archive.com/netdev@vger.kernel.org/msg22254.html),
I am pretty sure that "pattern" is a typo for "patent".  So I guess
the question is what exactly the patent covers and what the
implications of having the current kernel code are.

 - R.
