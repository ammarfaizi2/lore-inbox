Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVDZPWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVDZPWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVDZPV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:21:59 -0400
Received: from magic.adaptec.com ([216.52.22.17]:18903 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261568AbVDZPVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:21:16 -0400
Message-ID: <426E5BAF.4040003@adaptec.com>
Date: Tue, 26 Apr 2005 11:18:07 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       dougg@torque.net, Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
References: <425D392F.2080702@adaptec.com> <20050424111908.GA23010@infradead.org> <426D1572.70508@adaptec.com> <20050425161411.GA11938@infradead.org> <426D2723.8070308@adaptec.com> <20050425181831.GA14190@infradead.org>
In-Reply-To: <20050425181831.GA14190@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2005 15:18:09.0008 (UTC) FILETIME=[273F4700:01C54A73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/05 14:18, Christoph Hellwig wrote:
> The point is that discovery must happen for each HBA separately because
> we absolutely do not want to have global state.

OK.

Can you please define "global state"?

In SAS, when the domain changes, the controller(s) connected to the
domain get notification and pass it to the discovery process, which
will run again.

Overall, since the discovery process gets (internally) a "picture"
of the domain out there, it would be appropriate to show this
"picture" to the user.

	Luben
