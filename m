Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbUCUCXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 21:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbUCUCXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 21:23:10 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:30081 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263590AbUCUCXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 21:23:08 -0500
Message-ID: <405CFC85.70004@backtobasicsmgmt.com>
Date: Sat, 20 Mar 2004 19:23:01 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com>
In-Reply-To: <405CAEC7.9080104@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> So go ahead, and I'll lend you as much help as I can.  I have the full 
> Promise RAID docs, and it seems like another guy on the lists has full 
> Silicon Image "medley" RAID docs...

If these "soft" RAID implementations only support RAID-0/1/0+1/1+0, is 
there really any need for a new DM target? Wouldn't you just need a 
userspace tool to recognize the array and do the "dmsetup" operations to 
make it usable?
