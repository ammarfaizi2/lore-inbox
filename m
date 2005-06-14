Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVFNUEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVFNUEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVFNUEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:04:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261323AbVFNUE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:04:26 -0400
Date: Tue, 14 Jun 2005 13:03:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] files: scalable fd management (V4)
Message-Id: <20050614130338.70e99074.akpm@osdl.org>
In-Reply-To: <20050614142612.GA4557@in.ibm.com>
References: <20050614142612.GA4557@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> tiobench on a 4-way ppc64 system :
>                                          (lockfree)
>  Test            2.6.10-vanilla  Stdev   2.6.10-fd       Stdev
>  -------------------------------------------------------------
>  Seqread         1428            32.47   1475.0          29.11
>  Randread        1469.2          17.27   1599.6          35.95
>  Seqwrite        262.06          9.31    246.8           30.94
>  Randwrite       548.38          12.49   521.4           61.98

We don't seem to have gained anything?
