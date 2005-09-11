Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVIKDD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVIKDD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 23:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVIKDD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 23:03:56 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:62653 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932386AbVIKDD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 23:03:56 -0400
X-ORBL: [67.124.117.85]
Date: Sat, 10 Sep 2005 20:03:45 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand updates
Message-ID: <20050911030345.GA14593@taniwha.stupidest.org>
References: <523bocedcb.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523bocedcb.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 04:02:12PM -0700, Roland Dreier wrote:

>  include/rdma/ib_cm.h                      |    1
>  include/rdma/ib_mad.h                     |   21 ++
>  include/rdma/ib_sa.h                      |   31 +++
>  include/rdma/ib_user_cm.h                 |   72 +++++++
>  include/rdma/ib_user_verbs.h              |   21 ++

Do these really need to be here?  if we really must merge RDMA can we
not hide these headers in drivers/inifiniband for now?
