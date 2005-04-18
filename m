Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVDRI6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVDRI6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVDRI6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:58:54 -0400
Received: from [213.170.72.194] ([213.170.72.194]:20894 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261975AbVDRI6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:58:52 -0400
Subject: Re: [PATC] small VFS change for JFFS2
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       dwmw2@lists.infradead.org
In-Reply-To: <20050418085121.GA19091@infradead.org>
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
	 <20050418085121.GA19091@infradead.org>
Content-Type: text/plain
Organization: MTD
Date: Mon, 18 Apr 2005 12:58:50 +0400
Message-Id: <1113814730.31595.6.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 09:51 +0100, Christoph Hellwig wrote:
> No, exporting locks is a really bad idea.  Please try to find a better
> method to fix your problem that doesn't export random kernel symbols.
> 
In general it must be true. But this specific case I believe is
reasonable enough to export the mutext (as an exception).

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

