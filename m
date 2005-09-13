Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbVIMNLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVIMNLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 09:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVIMNLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 09:11:32 -0400
Received: from magic.adaptec.com ([216.52.22.17]:9112 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932645AbVIMNLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 09:11:31 -0400
Message-ID: <4326CFEF.2000005@adaptec.com>
Date: Tue, 13 Sep 2005 09:11:11 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Patrick Mansfield <patmans@us.ibm.com>,
       James Bottomley <James.Bottomley@SteelEye.com>, ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com> <1126368081.4813.46.camel@mulgrave> <4325997D.3050103@adaptec.com> <20050912162739.GA11455@us.ibm.com> <4326964B.9010503@torque.net>
In-Reply-To: <4326964B.9010503@torque.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 13:11:17.0633 (UTC) FILETIME=[A0589F10:01C5B864]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 05:05, Douglas Gilbert wrote:
> The technique of supporting REPORT_LUNS on lun 0 of
> a target in the case where there is no such device
> (logical unit) is a pretty ugly. It also indicates what
> is really happening: the target device intercepts
> REPORT_LUNS, builds the response and replies on behalf
> of lun 0.
> 
> Turns out there are other reasons an application may want
> to "talk" to a target device rather than one of its logical
> units (e.g. access controls and log pages specific to
> the target's transport). Well known lus can be seen with the
> REPORT_LUNS (select_report=1) but there is no mechanism (that
> I am aware of) that allows anyone to access them
> from the user space with linux.
> 
> 
> References at www.t10.org:
>    spc4r01a.pdf  [section 8]
>    bcc-r00.pdf   [bridge controller commands]

Well, I'm certainly glad that Doug is getting involved
and on a SCSI professional level (quoting specs etc.).

We need more SAM (SCSI-3) expertise in linux-scsi and
linux-kernel.

	Luben
