Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268981AbRHPXN0>; Thu, 16 Aug 2001 19:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268997AbRHPXNR>; Thu, 16 Aug 2001 19:13:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24704 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268981AbRHPXNM>;
	Thu, 16 Aug 2001 19:13:12 -0400
Date: Thu, 16 Aug 2001 16:11:15 -0700 (PDT)
Message-Id: <20010816.161115.95062340.davem@redhat.com>
To: phillips@bonn-fries.net
Cc: tpepper@vato.org, f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010816230719Z16545-1231+1256@humbolt.nl.linux.org>
In-Reply-To: <20010816144109.A5094@cb.vato.org>
	<20010816.153151.74749641.davem@redhat.com>
	<20010816230719Z16545-1231+1256@humbolt.nl.linux.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@bonn-fries.net>
   Date: Fri, 17 Aug 2001 01:13:38 +0200

   What is wrong with using typeof?

Users don't think about the type that way, the new macros forces them
to at least consider it for a moment.

   If you must have a three argument min, 
   could it please be called "type_min" of similar.

We wanted people trying to use "min" and "max" with 2
args, or redefining their own, to get a compile error.

Later,
David S. Miller
davem@redhat.com
