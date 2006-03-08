Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWCHASg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWCHASg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWCHASg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:18:36 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:39808 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750938AbWCHASf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:18:35 -0500
Subject: [RFC PATCH 0/3]  VFS changes to collapse all the vectored and AIO
	support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Zach Brown <zach.brown@oracle.com>, christoph <hch@lst.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, pbadari@us.ibm.com
Content-Type: text/plain
Date: Tue, 07 Mar 2006 16:19:59 -0800
Message-Id: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series of changes collapses all the vectored IO support 
into single file-operation method using aio_read/aio_write. 

This work was originally suggested & started by Christoph Hellwig, 
when Zach Brown tried to add vectored support for AIO. 

Christoph & Zach, comments/suggestions ? If you are happy with the
work, can you add your Sign-off or Ack ? I addressed all the
known issues, please review.

Here is the summary:

[PATCH 1/3] Vectorize aio_read/aio_write methods

[PATCH 2/3] Remove readv/writev methods and use aio_read/aio_write
instead.

[PATCH 3/3] Zach's core aio changes to support vectored AIO.

NOTE: This is not ready for -mm or mainline consumption yet -
since I am still doing basic testing. 

Comments ?

Thanks,
Badari

