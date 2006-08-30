Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWH3JJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWH3JJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWH3JJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:09:18 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:58397 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750749AbWH3JJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:09:17 -0400
In-Reply-To: <OFED0915E4.3CED6795-ONC12571CE.0053ECB8-C12571CE.0055546A@LocalDomain>
Subject: Re: [PATCH 02/13] IB/ehca: includes
To: abergman@de.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org
Cc: Marcus Eder <MEDER@de.ibm.com>, Roland Dreier <rolandd@cisco.com>,
       Christoph Raisch <RAISCH@de.ibm.com>
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OF23CA96AE.C7DBFD52-ONC12571DA.00321849-C12571DA.00324865@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Wed, 30 Aug 2006 11:13:26 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 30/08/2006 11:13:27
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Christoph Raisch wrote on 18.08.2006 17:35:54:
> we'll change these EDEBs to a wrapper around dev_err, dev_dbg and
> dev_warn as it's done in the mthca driver.
> All EDEB_EN and EDEB_EX will be removed, that type of tracing can be
> done if needed by kprobes.
> There are a few cases where we won't get to a dev, for these few
> places we'll use a simple wrapper around printk, as done in ipoib.
We incorporated those changes throughout ehca code, which is accessible
from
Roland's git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git
for-2.6.19
Further comments/suggestions are appreciated!
Regards
Hoang-Nam Nguyen

