Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUDUUrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUDUUrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUDUUrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:47:10 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:43019 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263709AbUDUUqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:46:11 -0400
Date: Wed, 21 Apr 2004 21:46:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040421214605.A11291@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <OF9B34CCE6.C0CD3DC5-ONC1256E7D.005B1592-C1256E7D.005B528B@de.ibm.com> <20040421204303.GA5014@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040421204303.GA5014@in.ibm.com>; from dipankar@in.ibm.com on Thu, Apr 22, 2004 at 02:13:04AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 02:13:04AM +0530, Dipankar Sarma wrote:
> I think CPU_MASK_NONE can be used only for assignments. You need
> to actually declare a generic idle_cpu_mask and set it to CPU_MASK_NONE
> for all other archs. Of course, then the compiler will not be able
> to optimize it out :)

Well, there's a const keyword in C these days, no?

