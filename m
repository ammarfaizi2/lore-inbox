Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVGLTAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVGLTAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVGLS74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:59:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34238
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262195AbVGLS6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:58:44 -0400
Date: Tue, 12 Jul 2005 11:58:35 -0700 (PDT)
Message-Id: <20050712.115835.42775885.davem@davemloft.net>
To: kaber@trash.net
Cc: dsd@gentoo.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 netfilter: local packets marked as invalid
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42D3B063.3000207@trash.net>
References: <42CE8E96.1040905@trash.net>
	<42CEA5E4.40009@gentoo.org>
	<42D3B063.3000207@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Tue, 12 Jul 2005 13:58:27 +0200

> Daniel Drake wrote:
> > You'll have to forgive my lack of netfilter knowledge, I set up my firewall
> > ages ago and haven't really touched it since :)
> 
> We decided to revert the responsible change because it caused problems
> in other areas as well. This patch should fix your problem.

Applied.

Now the question is what to do about the 2.6.12.x stable
tree.  I think we put the offending change there, now we
need to revert it there too.  Patrick, could you push this
patch to stable@kernel.org so we can resolve that too?

Thanks a lot.
