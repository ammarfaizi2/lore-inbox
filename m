Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTEMEHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbTEMEHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:07:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37265 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261151AbTEMEHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:07:06 -0400
Date: Mon, 12 May 2003 20:14:02 -0700 (PDT)
Message-Id: <20030512.201402.55842955.davem@redhat.com>
To: kaber@trash.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix typo in 2.4 ipsec backport
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EC05839.6030702@trash.net>
References: <3EC05839.6030702@trash.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick McHardy <kaber@trash.net>
   Date: Tue, 13 May 2003 04:28:09 +0200

   This patch fixes a 0x10-ptr dereference in __xfrm4_find_acq ;)
   
The same bug is in 2.5.x too.  It's fallout from James Morris's
atomic_inc() --> xfrm_state_get() cleanup.

Applied, thanks a lot.
