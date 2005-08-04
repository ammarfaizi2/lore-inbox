Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVHDSdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVHDSdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVHDSdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:33:00 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:58026 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262543AbVHDSc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:32:56 -0400
To: Grant Grundler <iod00d@hp.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] [RFC] Move InfiniBand .h files
X-Message-Flag: Warning: May contain useful information
References: <52iryla9r5.fsf@cisco.com>
	<20050804182016.GE20422@esmail.cup.hp.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 04 Aug 2005 11:32:50 -0700
In-Reply-To: <20050804182016.GE20422@esmail.cup.hp.com> (Grant Grundler's
 message of "Thu, 4 Aug 2005 11:20:16 -0700")
Message-ID: <5264ula6y5.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Aug 2005 18:32:50.0815 (UTC) FILETIME=[EB7490F0:01C59922]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Grant> Any thoughts on renaming drivers/infiniband to drivers/rdma
    Grant> at the same time?

    Grant> If you are going to churn...don't be shy about it :^)

Well, I'd rather avoid churn for purely political reasons.  The main
point of my proposal is to move the includes from drivers/ to
include/, but while we're at it me might as well pick a more neutral
directory name.

Moving drivers/infiniband to drivers/rdma has no technical merit right
now, so I'd rather wait and see how it makes sense to organize the
code we end up with.

 - R.
