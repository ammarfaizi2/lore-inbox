Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVCZDwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVCZDwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVCZDwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:52:30 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:23212 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261932AbVCZDwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:52:25 -0500
Subject: Re: [PATCH 6/7] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <91888D455306F94EBD4D168954A9457C01B70565@nacos172.co.lsil.com>
References: <91888D455306F94EBD4D168954A9457C01B70565@nacos172.co.lsil.com>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 21:52:17 -0600
Message-Id: <1111809137.5541.7.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 16:57 -0700, Moore, Eric Dean wrote:
> +static struct device_attribute mptscsih_queue_depth_attr = {
> +       .attr = {
> +               .name =         "queue_depth",
> +               .mode =         S_IWUSR,
> +       },
> +       .store = mpt_core_store_queue_depth,
> +};

But in the original which you're removing, this was implemented via the
change_queue_depth API.

It looks like the patches you're posting are actually an older version
of the fusion driver.   Do you have the split done on a current copy?

Thanks,

James


