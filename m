Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWHVVOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWHVVOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWHVVOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:14:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751269AbWHVVOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:14:04 -0400
Date: Tue, 22 Aug 2006 14:13:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: ananth@in.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, hch@infradead.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>, davem@davemloft.net,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH 2/3] Add retval_value helper (updated)
Message-Id: <20060822141307.672850d7.akpm@osdl.org>
In-Reply-To: <20060822052841.GB26279@in.ibm.com>
References: <20060822052448.GA26279@in.ibm.com>
	<20060822052841.GB26279@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 10:58:41 +0530
Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:

> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Add the return_value() macro to extract the return value in an
> architecture agnostic manner, given the pt_regs.
> 
> Other architecture maintainers may want to add similar helpers.

return_value() is quite a generic-sounding thing.

box:/usr/src/linux-2.6.18-rc4> grep -r return_value . | wc -l
66


How about regs_return_value()?
