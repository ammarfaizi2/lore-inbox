Return-Path: <linux-kernel-owner+w=401wt.eu-S1752752AbXACBMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbXACBMJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbXACBMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:12:09 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:56167 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbXACBMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:12:08 -0500
In-Reply-To: <000401c72bbe$7d715b30$d634030a@amr.corp.intel.com>
References: <000401c72bbe$7d715b30$d634030a@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C4665262-B509-4A30-A4B9-389500EA211F@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: remove spurious ring head index modulo info->nr
Date: Tue, 2 Jan 2007 17:12:06 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This makes the modulo of ring->head into local variable head  
> unnecessary.
> This patch removes that bogus code.

Looks fine to me:

Acked-by: Zach Brown <zach.brown@oracle.com>

- z
