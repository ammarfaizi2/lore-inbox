Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUFQU6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUFQU6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUFQU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:58:23 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:14804 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263166AbUFQU6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:58:08 -0400
Subject: Re: PATCH: Further aacraid work
From: James Bottomley <James.Bottomley@steeleye.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Alan Cox <alan@redhat.com>, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       y@redhat.com, Clay Haapala <chaapala@cisco.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040617204828.GC1495@holomorphy.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2407B@otce2k03.adaptec.com>
	<20040617203842.GC8705@devserv.devel.redhat.com> 
	<20040617204828.GC1495@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 Jun 2004 15:56:16 -0500
Message-Id: <1087505777.2210.82.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 15:48, William Lee Irwin III wrote:
> Say, could you guys try this? jejb seemed to get decent results with it.

To quantify, my previous results showed 40 merges out of about 32k
segments.

With this patch running the same test, I show 24,007 merges out of 19513
segments (which is about a 55% merger rate).

I also see merges up to 128 segments (the maximum allowed).

James


