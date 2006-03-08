Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWCHMop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWCHMop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWCHMop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:44:45 -0500
Received: from verein.lst.de ([213.95.11.210]:22164 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750779AbWCHMoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:44:44 -0500
Date: Wed, 8 Mar 2006 13:44:31 +0100
From: christoph <hch@lst.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Zach Brown <zach.brown@oracle.com>, christoph <hch@lst.de>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
Message-ID: <20060308124431.GA4128@lst.de>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <1141777330.17095.36.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141777330.17095.36.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:22:10PM -0800, Badari Pulavarty wrote:
> This patch vectorizes aio_read() and aio_write() methods to prepare
> for colapsing all the vectored operations into one interface -
> which is aio_read()/aio_write().

ok
