Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUCUSHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbUCUSHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:07:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263679AbUCUSHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:07:43 -0500
Message-ID: <405DD9E2.4030308@pobox.com>
Date: Sun, 21 Mar 2004 13:07:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com>
In-Reply-To: <405CFC85.70004@backtobasicsmgmt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:
> Jeff Garzik wrote:
> 
>> So go ahead, and I'll lend you as much help as I can.  I have the full 
>> Promise RAID docs, and it seems like another guy on the lists has full 
>> Silicon Image "medley" RAID docs...
> 
> 
> If these "soft" RAID implementations only support RAID-0/1/0+1/1+0, is 
> there really any need for a new DM target? Wouldn't you just need a 
> userspace tool to recognize the array and do the "dmsetup" operations to 
> make it usable?


Ideally yes.  I don't see an in-tree RAID1 dm target though....

	Jeff



