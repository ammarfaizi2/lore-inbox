Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWC0XmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWC0XmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWC0XmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:42:13 -0500
Received: from fmr19.intel.com ([134.134.136.18]:38361 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751154AbWC0XmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:42:13 -0500
Message-ID: <44287853.5020804@ichips.intel.com>
Date: Mon, 27 Mar 2006 15:42:11 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
References: <ada7j6f8xwi.fsf@cisco.com> <442848EF.4000407@ichips.intel.com> <adar74n5wbn.fsf@cisco.com>
In-Reply-To: <adar74n5wbn.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> BTW, what do you think of changing rdma_wq to be a GPL export, to give
> a hint that this is an internal symbol not really for general use?

I'm actually testing a patch set now that moves rdma_wq internal to ib_addr, and 
  gives the RDMA CM its own WQ.

- Sean

