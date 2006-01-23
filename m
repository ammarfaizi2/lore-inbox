Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWAWHof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWAWHof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 02:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWAWHof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 02:44:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19140 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964883AbWAWHof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 02:44:35 -0500
Subject: Re: [PATCH 2/9] device-mapper log bitset: fix endian
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060122213741.7d2ed8ef.akpm@osdl.org>
References: <20060120211300.GC4724@agk.surrey.redhat.com>
	 <20060122213741.7d2ed8ef.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 08:44:26 +0100
Message-Id: <1138002267.2977.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 21:37 -0800, Andrew Morton wrote:
> Alasdair G Kergon <agk@redhat.com> wrote:
> >
> >  -	set_bit(bit, (unsigned long *) bs);
> >  +	ext2_set_bit(bit, (unsigned long *) bs);
> 
> We really should give those things a more appropriate name.

or... kill them in favor of the real set_bit/__set_bit ?

