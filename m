Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263258AbTCSXXq>; Wed, 19 Mar 2003 18:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263260AbTCSXXq>; Wed, 19 Mar 2003 18:23:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263258AbTCSXXp>;
	Wed, 19 Mar 2003 18:23:45 -0500
Subject: Re: [RFC] linux-2.5.65_clock-override_A0
From: Stephen Hemminger <shemminger@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Jerry Cooperstein <coop@axian.com>
In-Reply-To: <1048114445.4821.256.camel@w-jstultz2.beaverton.ibm.com>
References: <1048114445.4821.256.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1048116881.1086.2.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Mar 2003 15:34:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 14:54, john stultz wrote:
> All,
> 	Inspired by Stephen Hemminger's "boot time parameter to turn of TSC
> usage" patch, I implemented my own version that is a tad bit more
> flexible. 

This is cleaner and better (relatively speaking) and avoids the problem of
cpu_khz being zero.

