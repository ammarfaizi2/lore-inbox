Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946905AbWKAPi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946905AbWKAPi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946907AbWKAPi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:38:27 -0500
Received: from smtp105.biz.mail.mud.yahoo.com ([68.142.200.253]:38231 "HELO
	smtp105.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946908AbWKAPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:38:26 -0500
Message-ID: <4548BF70.1060802@metricsystems.com>
Date: Wed, 01 Nov 2006 07:38:24 -0800
From: John Clark <jclark@metricsystems.com>
Organization: Metric Systems, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: sky2 driver causes kernel crash as of 2.6.18.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been compiling kernels from 2.6.16.16 on to see if there is any 
improvement
in the Sky2 driver. The most recent official kernel version, 2.6.18.1, 
as of 10/31/06
seems to still have problems.

The crash debug splat indicates that the transmit routine was being 
executed when
the final crash occured. But before the crash there were a series of 
diagnostics from
the driver:

NETDEV WATCHDOG: eth4: transmit time out
sky2 eth4: tx timeout
sky2 hardware hung? flushing

messages.

Is there any better driver in a 'unstable' kernel that someone has 
tested sufficiently?

Thanks
John Clark

