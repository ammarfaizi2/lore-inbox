Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWHJGlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWHJGlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWHJGlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:41:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161103AbWHJGlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:41:49 -0400
Date: Wed, 9 Aug 2006 23:41:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] 48-bit block numbers for extended attributes
Message-Id: <20060809234100.9337162d.akpm@osdl.org>
In-Reply-To: <1155172929.3161.87.camel@localhost.localdomain>
References: <1155172929.3161.87.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 18:22:09 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> As we are planning to support 48-bit block numbers for ext4,
> we need to support 48-bit block numbers for extended attributes.
> In the short term, we can do this by reuse (on-disk) 16-bit
> padding (linux2.i_pad1 currently used only by "hurd") as high 
> order bits for xattr. This patch basically does that.

Short-term tends to become medium-term, then you're stuck with it.

What is the plan here?
