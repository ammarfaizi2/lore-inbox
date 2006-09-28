Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWI1SOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWI1SOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWI1SOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:14:31 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:51387 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751374AbWI1SOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:14:30 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 24 of 28] IB/mthca - Fix compiler warnings with gcc4 on possible unitialized variables
X-Message-Flag: Warning: May contain useful information
References: <9fa624c592af68f7a851.1159459220@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 28 Sep 2006 11:14:28 -0700
In-Reply-To: <9fa624c592af68f7a851.1159459220@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Thu, 28 Sep 2006 09:00:20 -0700")
Message-ID: <adaslib5057.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Sep 2006 18:14:29.0313 (UTC) FILETIME=[F067B310:01C6E329]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NAK -- I don't want to generate worse code to fix a compiler warning
false positive.

 - R.
