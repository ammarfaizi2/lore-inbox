Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUHAReJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUHAReJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 13:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUHAReJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 13:34:09 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:905 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S266116AbUHARdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 13:33:06 -0400
Message-ID: <410D2949.20503@backtobasicsmgmt.com>
Date: Sun, 01 Aug 2004 10:32:57 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@istop.com>
CC: "Walker, Bruce J" <bruce.walker@hp.com>,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       opengfs-devel@lists.sourceforge.net,
       opengfs-users@lists.sourceforge.net,
       opendlm-devel@lists.sourceforge.net
Subject: Re: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
References: <3689AF909D816446BA505D21F1461AE4C750E6@cacexc04.americas.cpqcorp.net> <200408011330.01848.phillips@istop.com>
In-Reply-To: <200408011330.01848.phillips@istop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> On Saturday 31 July 2004 12:00, Walker, Bruce J wrote:
> 
>>In the 2.4 implementation, providing this one capability by
>>leveraging devfs was quite economic, efficient and has been very stable.
> 
> 
> I wonder if device-mapper (slightly hacked) wouldn't be a better approach for 
> 2.6+.

It appeared from the original posting that their "cluster-wide devfs" 
actually supported all types of device nodes, not just block devices. I 
don't know whether accessing a character device on another node would 
ever be useful, but certainly using device-mapper wouldn't help for that 
case.
