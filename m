Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTFHXLR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTFHXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:11:17 -0400
Received: from dsl081-085-006.lax1.dsl.speakeasy.net ([64.81.85.6]:26764 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id S264037AbTFHXLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:11:15 -0400
Message-ID: <3EE3C5C4.70405@tmsusa.com>
Date: Sun, 08 Jun 2003 16:24:52 -0700
From: Joe <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-mm6
References: <20030607151440.6982d8c6.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All in all -mm6 seems fine here but for two small
problems, one of which is the continuing issue with
gdm which first surfaced in -mm5 IIRC -

Jun  7 18:32:01 jyro kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jun  7 18:32:01 jyro kernel: ip_conntrack version 2.1 (4086 buckets, 
32688 max)
- 324 bytes per conntrack
Jun  7 18:32:06 jyro gdm[1282]: gdm_slave_xioerror_handler: Fatal X 
error - Restarting :0
Jun  7 18:32:07 jyro gdm[1293]: gdm_slave_xioerror_handler: Fatal X 
error - Restarting :0
Jun  7 18:32:12 jyro gdm[1305]: gdm_slave_xioerror_handler: Fatal X 
error - Restarting :0
Jun  7 18:32:16 jyro gdm[1311]: gdm_slave_xioerror_handler: Fatal X 
error - Restarting :0
Jun  7 18:32:16 jyro gdm[1237]: deal_with_x_crashes: Running the 
XKeepsCrashing script
Jun  7 18:32:54 jyro gdm[1237]: Failed to start X server several times 
in a short time period; disabling display :0




