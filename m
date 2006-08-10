Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWHJGy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWHJGy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWHJGy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:54:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:46290 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161067AbWHJGy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:54:58 -0400
Message-ID: <44DAD83F.701@garzik.org>
Date: Thu, 10 Aug 2006 02:54:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/9] 48bit support in extents
References: <1155172873.3161.83.camel@localhost.localdomain> <20060809234054.f9365c4b.akpm@osdl.org>
In-Reply-To: <20060809234054.f9365c4b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I think that requiring 64-bit sector_t is reasonable?

Internally, you might as well just use u64...

	Jeff


