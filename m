Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXL2d>; Wed, 24 Jan 2001 06:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRAXL2X>; Wed, 24 Jan 2001 06:28:23 -0500
Received: from zeus.kernel.org ([209.10.41.242]:2003 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129401AbRAXL2J>;
	Wed, 24 Jan 2001 06:28:09 -0500
Date: Wed, 24 Jan 2001 11:26:24 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: V Ganesh <ganesh@veritas.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: inode->i_dirty_buffers redundant ?
Message-ID: <20010124112624.M11607@redhat.com>
In-Reply-To: <200101240955.PAA28367@vxindia.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200101240955.PAA28367@vxindia.veritas.com>; from ganesh@veritas.com on Wed, Jan 24, 2001 at 03:25:16PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 24, 2001 at 03:25:16PM +0530, V Ganesh wrote:
> now that we have inode->i_mapping->dirty_pages, what do we need
> inode->i_dirty_buffers for ?

Metadata.  Specifically, directory contents and indirection blocks.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
