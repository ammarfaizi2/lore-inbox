Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbRHQBxq>; Thu, 16 Aug 2001 21:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRHQBxg>; Thu, 16 Aug 2001 21:53:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58752 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269412AbRHQBxX>;
	Thu, 16 Aug 2001 21:53:23 -0400
Date: Thu, 16 Aug 2001 18:50:18 -0700 (PDT)
Message-Id: <20010816.185018.102580124.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B7C7235.1E09C034@linux-m68k.org>
In-Reply-To: <5.1.0.14.2.20010816234350.00add710@pop.cus.cam.ac.uk>
	<20010816.163852.115909286.davem@redhat.com>
	<3B7C7235.1E09C034@linux-m68k.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Fri, 17 Aug 2001 03:24:05 +0200

   2. This macro doesn't produce a warning like the typeof version does.
   The typeof version warns you about signed/unsigned compares, while an
   assignment gives no warning.

That is a legitimate operation, there is no reason to prevent people
from comparing signed and unsigned values.  These type argument
min/max values allow people to specify what the comparison type
degenerates into.

Later,
David S. Miller
davem@redhat.com
