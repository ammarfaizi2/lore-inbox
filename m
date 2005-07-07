Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVGGCIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVGGCIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVGGCIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 22:08:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57315
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262451AbVGGCIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 22:08:05 -0400
Date: Wed, 06 Jul 2005 19:07:58 -0700 (PDT)
Message-Id: <20050706.190758.71090134.davem@davemloft.net>
To: akpm@osdl.org
Cc: davej@redhat.com, pmarques@grupopie.com, linux-kernel@vger.kernel.org
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050706181220.3978d7f6.akpm@osdl.org>
References: <20050706.125719.08321870.davem@davemloft.net>
	<20050706205315.GC27630@redhat.com>
	<20050706181220.3978d7f6.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 6 Jul 2005 18:12:20 -0700

> ouch.   What do we do?  Default to off?  Default to off on xmeta?

Good question.  Whatever security is gained by the va randomization
stuff is definitely not worth a 0.23 --> 3.0 second performance
regression.
