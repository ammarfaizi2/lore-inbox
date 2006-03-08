Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWCHDnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWCHDnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWCHDnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:43:22 -0500
Received: from kanga.kvack.org ([66.96.29.28]:11405 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750731AbWCHDnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:43:21 -0500
Date: Tue, 7 Mar 2006 22:37:57 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Zach Brown <zach.brown@oracle.com>, christoph <hch@lst.de>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/3] Zach's core aio changes to support vectored AIO
Message-ID: <20060308033757.GR5410@kvack.org>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <1141777459.17095.41.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141777459.17095.41.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:24:19PM -0800, Badari Pulavarty wrote:
> This work is initially done by Zach Brown to add support for
> vectored aio. These are the core changes for AIO to support
> IOCB_CMD_PREADV/IOCB_CMD_PWRITEV.

Please, please, please send patches inline so they can be quoted.  In 
any case, there's a bug in the PREADV/WRITEV code in that it doesn't 
check the selinux security bits for the file.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
