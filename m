Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUFWPFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUFWPFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbUFWPFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:05:06 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:29895 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266249AbUFWPEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:04:51 -0400
Date: Wed, 23 Jun 2004 08:04:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: slow performance w/patch-2.6.7-mjb1
Message-ID: <1945190000.1088003081@[10.10.2.4]>
In-Reply-To: <20040623013419.18165.qmail@web51805.mail.yahoo.com>
References: <20040623013419.18165.qmail@web51805.mail.yahoo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I configed with your patch just the basics and get
> similar times that I do with 2.6.7 virigin and 2.4.21.
>  However, as soon as I enable 4G split, the rt
> increases by ~35s (out of 1m45s compared to 1m10s). 
> Do you know if this is in line w/expectations?  Is
> there anyway to reduce this?

Syscalls, etc will definitely be slower ... but it's not normally
that severe ... what's the workload? And how much of hte increase
is systime vs user time? (use /usr/bin/time, not the shell builtin)

M.



