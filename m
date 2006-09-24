Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWIXAj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWIXAj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 20:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWIXAj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 20:39:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47305
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751294AbWIXAjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 20:39:25 -0400
Date: Sat, 23 Sep 2006 17:39:24 -0700 (PDT)
Message-Id: <20060923.173924.78710069.davem@davemloft.net>
To: samuel.thibault@ens-lyon.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no SA_NODEFER on sparc?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
References: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri, 8 Sep 2006 02:06:02 +0200

> I noticed that the sparc arch misses a definition for SA_NODEFER. Is
> that on purpose?  If not, here is a patch for fixing this.
> 
> Add SA_NODEFER, deprecating linuxish SA_NOMASK.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

I have no problems with this patch.  Userland headers already
define both SA_NODEFER and SA_NOMASK on Sparc.
