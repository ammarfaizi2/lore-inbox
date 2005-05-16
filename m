Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVEPUvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVEPUvd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVEPUvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:51:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16814 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261870AbVEPUva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:51:30 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
From: Lee Revell <rlrevell@joe-job.com>
To: christoph <christoph@scalex86.org>
Cc: linux-kernel@vger.kernel.org, shai@scalex86.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
Content-Type: text/plain
Date: Mon, 16 May 2005 16:51:29 -0400
Message-Id: <1116276689.28764.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 12:45 -0700, christoph wrote:
> Make the timer frequency selectable. The timer interrupt may cause bus
> and memory contention in large NUMA systems since the interrupt occurs
> on each processor HZ times per second.

Isn't there already a patch in the -ac kernel that allows HZ to be
selected at runtime?

Lee

