Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVHHRdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVHHRdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVHHRdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:33:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22703
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932132AbVHHRdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:33:10 -0400
Date: Mon, 08 Aug 2005 10:33:04 -0700 (PDT)
Message-Id: <20050808.103304.55507512.davem@davemloft.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linville@redhat.com, torvalds@osdl.org
Subject: Re: pci_update_resource() getting called on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050808144439.GA6478@kroah.com>
References: <20050808.071211.74753610.davem@davemloft.net>
	<20050808144439.GA6478@kroah.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Mon, 8 Aug 2005 07:44:40 -0700

> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43c34735524d5b1c9b9e5d63b49dd4c1b394bde4
> 
> Although in glancing at it, it might not be the reason...

No, that isn't it.

Perhaps it was one of those changes that Linus was doing
to deal with interrupt setting restoration after resume?
