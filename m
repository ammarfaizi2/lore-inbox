Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWCHMpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWCHMpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWCHMpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:45:19 -0500
Received: from verein.lst.de ([213.95.11.210]:26260 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751081AbWCHMpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:45:17 -0500
Date: Wed, 8 Mar 2006 13:45:11 +0100
From: christoph <hch@lst.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Zach Brown <zach.brown@oracle.com>, christoph <hch@lst.de>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/3] Remove readv/writev methods and use aio_read/aio_write instead
Message-ID: <20060308124511.GB4128@lst.de>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <1141777382.17095.38.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141777382.17095.38.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:23:02PM -0800, Badari Pulavarty wrote:
> This patch removes readv() and writev() methods and replaces
> them with aio_read()/aio_write() methods.

you have the io_fn_t/io_fnv_t typedefs both in read_write.c and
read_write.h - they really should be in the latter only.

else ok.
