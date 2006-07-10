Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWGJLS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWGJLS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWGJLS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:18:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44978 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751385AbWGJLS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:18:27 -0400
Subject: Re: [PATCH] IB/mthca: comment fix
From: Arjan van de Ven <arjan@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Zach Brown <zach.brown@oracle.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060710111412.GD24705@mellanox.co.il>
References: <20060710111412.GD24705@mellanox.co.il>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 13:18:09 +0200
Message-Id: <1152530289.4874.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 14:14 +0300, Michael S. Tsirkin wrote:
> Hi Andrew,
> Here's a cosmetic patch for IB/mthca. Pls drop it into -mm and on.
> 
> ---
> 
> comment in mthca_qp.c makes it seem lockdep is the only reason WQ locks should
> be initialized separately, but as Zach Brown and Roland pointed out, there are
> other reasons, e.g. that mthca_wq_init is called from modify qp as well.

ehh.. shouldn't the comment say that instead then? that's one tricky
thing and might as well have that documented in the code!

