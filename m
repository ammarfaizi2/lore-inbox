Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWKGPeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWKGPeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWKGPeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:34:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42884 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932088AbWKGPeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:34:22 -0500
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to	 
	PAGE_CACHE_SIZE
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Steve French <smfltc@us.ibm.com>
Cc: Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>
In-Reply-To: <1162906845.8123.11.camel@kleikamp.austin.ibm.com>
References: <454FAE0A.3070409@redhat.com>
	 <1162852069.11030.70.camel@kleikamp.austin.ibm.com>
	 <454FD2BE.2090302@us.ibm.com>
	 <1162906845.8123.11.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 09:34:12 -0600
Message-Id: <1162913653.8123.13.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 07:40 -0600, Dave Kleikamp wrote:
> It would probably be best to just set stat->blksize to the negotiated
> buffer size.

But be careful here.  I don't know how applications/glibc may behave if
stat->blksize is not a power of 2.
-- 
David Kleikamp
IBM Linux Technology Center

