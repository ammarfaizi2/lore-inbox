Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUEJPUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUEJPUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbUEJPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:20:15 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:60428 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264526AbUEJPUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:20:13 -0400
Date: Mon, 10 May 2004 16:20:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040510162012.B3856@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510024506.1a9023b6.akpm@osdl.org>; from akpm@osdl.org on Mon, May 10, 2004 at 02:45:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, one more thing as you're probably sending the i_shared_sem re-
spinlockification to Linus just about now: as we're renaming the thing
anyway can we give it a less confusing name like i_mmap_lock?  It's not
been about shared mapping only for ages.
