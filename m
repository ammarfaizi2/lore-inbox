Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTEDHlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 03:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbTEDHlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 03:41:25 -0400
Received: from verein.lst.de ([212.34.181.86]:18957 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263549AbTEDHlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 03:41:24 -0400
Date: Sun, 4 May 2003 09:53:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] how to fix is_local_disk()?
Message-ID: <20030504095348.A7684@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030504090003.A7285@lst.de> <20030504003021.077e8819.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030504003021.077e8819.akpm@digeo.com>; from akpm@digeo.com on Sun, May 04, 2003 at 12:30:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 12:30:21AM -0700, Andrew Morton wrote:
> Suggest you chainsaw the whole lot and simply do a wakeup_bdflush(0) from
> interrupt context.

That's fine for the sync case but what about the remount r/o case?

