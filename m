Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUIFV2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUIFV2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIFV2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:28:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:48595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267343AbUIFV2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:28:52 -0400
Date: Mon, 6 Sep 2004 14:26:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: blaisorblade_spam@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
Subject: Re: [patch 1/3] uml-ubd-no-empty-queue
Message-Id: <20040906142641.067fdeb6.akpm@osdl.org>
In-Reply-To: <20040906174447.238788D1E@zion.localdomain>
References: <20040906174447.238788D1E@zion.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't use a filename like uml-ubd-no-empty-queue as the Subject:
of your patches.  Please prepare an English-language summary.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

I applied three of these - two got rejects against Linus's current
tree.

Do you have to do this

 -menu "SCSI support"
 +if BROKEN
 +	menu "SCSI support"
  
 -config SCSI

I think you'll find that

	menu "SCSI support"
	depends on BROKEN

works OK.
