Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWCBVmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWCBVmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWCBVmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:42:19 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:5304 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932566AbWCBVmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:42:17 -0500
Subject: RE: Question: how to map SCSI data DMA address to virtual address?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Jens Axboe <axboe@suse.de>, Linux kernel <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <9738BCBE884FDB42801FAD8A7769C2651420C5@NAMAIL1.ad.lsil.com>
References: <9738BCBE884FDB42801FAD8A7769C2651420C5@NAMAIL1.ad.lsil.com>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 15:42:07 -0600
Message-Id: <1141335727.3238.66.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 14:04 -0700, Ju, Seokmann wrote:
> Thank you for your valueable comment. One good thing is that the system does 2 GB memory so that highmem won't come into picture. I am implementing the feature with suggestions.

2GB is well into highmem on a traditional x86 with a 3/1 split.

For a private project, you're free to do as you wish subject to the
constraints of the GPL.  However, if you want whatever you're planning
to go upstream someday you need to conform to the requirements of the
Linux API which are as Jens and Christoph have already outlined.

James


