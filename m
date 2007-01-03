Return-Path: <linux-kernel-owner+w=401wt.eu-S1750774AbXACN3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXACN3i (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbXACN3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:29:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39799 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbXACN3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:29:37 -0500
Subject: Re: [2.6 PATCH] Export invalidate_mapping_pages() to modules.
From: Arjan van de Ven <arjan@infradead.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0701012322050.1218@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0701012322050.1218@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 03 Jan 2007 05:29:31 -0800
Message-Id: <1167830972.3095.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 23:28 +0000, Anton Altaparmakov wrote:
> Hi Linus and Andrew,
> 
> Please apply below patch which exports invalidate_mapping_pages() to 
> modules.  It makes no sense to me to export invalidate_inode_pages() and 
> not invalidate_mapping_pages() and I actually need 
> invalidate_mapping_pages() because of its range specification ability...
> 
> It would be great if this could make it into 2.6.20!


yet.. if there's not a single user it makes the kernel binary 100 to 150
bytes bigger in memory......  

