Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTLAOPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTLAOPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:15:31 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:39849 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263531AbTLAOP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:15:29 -0500
Message-ID: <3FCB4CFA.4020302@backtobasicsmgmt.com>
Date: Mon, 01 Dec 2003 07:15:22 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de>
In-Reply-To: <20031201141144.GD12211@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>Hardware is a 2.6CGHz P4, 1G of RAM (4G highmem enabled), SMP kernel but 
>>no preemption. Kernel config is at:
> 
> 
> Are you using ide or libata as the backing for the sata drives?
> 

libata, two of the disks are on an ICH5 and the other four are on a 
Promise SATA150 TX4.

