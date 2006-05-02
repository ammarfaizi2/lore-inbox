Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWEBH43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWEBH43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWEBH43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:56:29 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:55110 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S932419AbWEBH43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:56:29 -0400
Message-ID: <445710AA.9080709@voltaire.com>
Date: Tue, 02 May 2006 10:56:26 +0300
From: Or Gerlitz <ogerlitz@voltaire.com>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iSER (iSCSI Extensions for RDMA) initiator
References: <Pine.LNX.4.44.0604271528140.16463-100000@zuben> <adar73dvbo7.fsf@cisco.com>
In-Reply-To: <adar73dvbo7.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 07:56:27.0470 (UTC) FILETIME=[EA5ABEE0:01C66DBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Is this ready for queuing in my for-2.6.18 tree?  What is the status
> of all the non-IB dependencies?
 > If it is ready for merging, please send me a clean patch series with
 > the comments from this thread addressed.  And also remind me of which
 > SCSI git trees this depends on...

I am working on reviewing / applying fixes to the comments, and will
send you a clean patch set when done.

The only non-IB dependency is in the iSCSI updates for 2.6.18. The git 
from which those updates are pushed upstream is scsi-misc-2.6 . Now, 
James have accepted into it 5/6 of the updates (see below) but there's 
still one which is not there yet. I will let you know.

Or.

Mike Christie 	[SCSI] iscsi: convert iscsi tcp to libiscsi 	
Mike Christie 	[SCSI] iscsi: add libiscsi 	
Mike Christie 	[SCSI] iscsi: fix up iscsi eh 	
Mike Christie 	[SCSI] iscsi: add sysfs attrs for uspace sync up 	
Mike Christie 	[SCSI] iscsi: rm kernel iscsi handles usage for session




