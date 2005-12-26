Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVLZCt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVLZCt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 21:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbVLZCt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 21:49:27 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:12584 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750982AbVLZCt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 21:49:26 -0500
X-IronPort-AV: i="3.99,292,1131350400"; 
   d="scan'208"; a="383135343:sNHT29685300"
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 13/13]  [RFC] ipath Kconfig and Makefile
X-Message-Flag: Warning: May contain useful information
References: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com>
	<200512161548.lokgvLraSGi0enUH@cisco.com>
	<20051218192356.GB9145@mars.ravnborg.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 25 Dec 2005 18:49:19 -0800
In-Reply-To: <20051218192356.GB9145@mars.ravnborg.org> (Sam Ravnborg's
 message of "Sun, 18 Dec 2005 20:23:56 +0100")
Message-ID: <adaoe34fu8g.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 26 Dec 2005 02:49:20.0969 (UTC) FILETIME=[F8D79390:01C609C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +EXTRA_CFLAGS += -Idrivers/infiniband/include

> If this is needed then some header files should be moved to include/rdma

Sorry, this is really my fault -- it's a remnant to make building our
subversion tree easier.  It's not needed when the driver is part of
the kernel proper, and I'll make sure to remove it when finally
merging.

Thanks,
  Roland
