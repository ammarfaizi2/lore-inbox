Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265451AbSJSBjw>; Fri, 18 Oct 2002 21:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265453AbSJSBjw>; Fri, 18 Oct 2002 21:39:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57804 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265451AbSJSBjw>;
	Fri, 18 Oct 2002 21:39:52 -0400
Date: Fri, 18 Oct 2002 18:38:11 -0700 (PDT)
Message-Id: <20021018.183811.124466701.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfree rtcache using RCU
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021019065210.A26806@in.ibm.com>
References: <20021019065210.A26806@in.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dipankar, I had to revert this patch.

Where is read_barrier_depends() defined?
I do not see it in current 2.5.x sources.
