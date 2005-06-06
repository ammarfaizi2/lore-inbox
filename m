Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVFFVna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVFFVna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVFFVn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:43:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:36747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261701AbVFFVnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:43:19 -0400
Date: Mon, 6 Jun 2005 14:43:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: jayalk@intworks.biz
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [RFC/PATCH 2.6.12-rc5 1/1] Framebuffer driver for Arc LCD board
Message-Id: <20050606144352.140cfe42.akpm@osdl.org>
In-Reply-To: <200506061416.j56EG18b017582@intworks.biz>
References: <200506061416.j56EG18b017582@intworks.biz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jayalk@intworks.biz wrote:
>
> I did this diff against
> rc5. Should I be doing it against -mm instead?

I generally prefer diffs against whatever is in -mm, mainly so we can see
what changed, and so that we can make sure that everyones fixups didn't get
lost.

If a patch has only been in -mm for a short period then a wholesale
replacement is OK.  It gets a bit complex because people do insist on trying
to add lots of trailing whitespace to the tree and I do insist on thwarting
them, but I fix all that up.

In this case I got anal and turned your new patch into an incremental one ;)
