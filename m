Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbUBYVvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUBYVuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:50:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:49588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261632AbUBYVuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:50:00 -0500
Date: Wed, 25 Feb 2004 13:51:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3: mark_info_dirty needs export
Message-Id: <20040225135152.60aae672.akpm@osdl.org>
In-Reply-To: <200402252326.46794.arvidjaar@mail.ru>
References: <200402252326.46794.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> WARNING: /lib/modules/2.6.3-mm3/kernel/fs/quota_v2.ko needs unknown symbol 
> mark_info_dirty
> make: Leaving directory `/home/bor/src/linux-2.6.3-mm3'
> 

Yes, the quota patches need a ton of exports.  But Jan is redoing all the
patches so nobody has done anything.
