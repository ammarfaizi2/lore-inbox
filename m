Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVC0PEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVC0PEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 10:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVC0PEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 10:04:44 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:37313 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261691AbVC0PE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 10:04:27 -0500
Subject: Re: [PATCH 6/7] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050327091630.GA938785@sgi.com>
References: <91888D455306F94EBD4D168954A9457C01B70565@nacos172.co.lsil.com>
	 <1111809137.5541.7.camel@mulgrave>  <20050327091630.GA938785@sgi.com>
Content-Type: text/plain
Date: Sun, 27 Mar 2005 09:04:17 -0600
Message-Id: <1111935857.5567.17.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 01:16 -0800, Jeremy Higdon wrote:
> James, actually this queue depth code predates your change_queue_depth
> API.  I don't think it was ever converted to the new API.

Erk, you're right.  My todo list says I'm only waiting on 3ware patches
for all the conversions to be complete, but I think I missed auditing
fusion because it's not in the scsi directory...OK I'll do it after we
get the driver split sorted out.

James


