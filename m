Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTEAWRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbTEAWRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:17:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65223 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262720AbTEAWRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:17:10 -0400
Date: Thu, 01 May 2003 14:22:35 -0700 (PDT)
Message-Id: <20030501.142235.91789378.davem@redhat.com>
To: Steve@ChyGwyn.com, steve@gw.chygwyn.com
Cc: hch@infradead.org, linux-decnet-user@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305012135.WAA19582@gw.chygwyn.com>
References: <20030501215709.A28210@infradead.org>
	<200305012135.WAA19582@gw.chygwyn.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steven Whitehouse <steve@gw.chygwyn.com>
   Date: Thu, 1 May 2003 22:35:46 +0100 (BST)

   > The name is a bit generic for an export function.  What about
   > seq_release_kfree?
   
   Yes, I'd considered that and eventually settled for the non-prefixed version
   since it followed the pattern set by single_release() which doesn't have
   the seq_ prefix. I don't mind changing it though if the prefixed version is
   preferred,

I think a naming convention without a prefix is asking for
trouble.  I'd ask that you add the prefix, the current convention
is troublesome and someone ought to clean that up.
