Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUG2Thx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUG2Thx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUG2Thw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:37:52 -0400
Received: from canuck.infradead.org ([205.233.218.70]:26631 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S263980AbUG2Tho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:37:44 -0400
Subject: Re: 2.6.8-rc2-mm1
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jffs-dev@axis.com
In-Reply-To: <20040729143606.GB2349@fs.tum.de>
References: <20040728020444.4dca7e23.akpm@osdl.org>
	 <20040729143606.GB2349@fs.tum.de>
Content-Type: text/plain
Date: Thu, 29 Jul 2004 15:36:32 -0400
Message-Id: <1091129792.4133.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 16:36 +0200, Adrian Bunk wrote:
> The following issue comes from Linus' tree:
> 
> JFFS2_COMPRESSION_OPTIONS is asked even if JFFS2_FS support isn't 
> selected.
> 
> The patch below adds a dependency on JFFS2_FS to 
> JFFS2_COMPRESSION_OPTIONS.

That was already at bk://linux-mtd.bkbits.net/mtd-2.6 for Linus to pull.

> I've also added a dependency on EXPERIMENTAL which seemed to be logical 
> after reading the description of this option (but even if you disagree 
> with this, please add the dependency on JFFS2_FS).

Not correct.

-- 
dwmw2

