Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263241AbSJJFWJ>; Thu, 10 Oct 2002 01:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbSJJFWJ>; Thu, 10 Oct 2002 01:22:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39095 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263241AbSJJFWI>;
	Thu, 10 Oct 2002 01:22:08 -0400
Date: Wed, 09 Oct 2002 22:20:37 -0700 (PDT)
Message-Id: <20021009.222037.81091737.davem@redhat.com>
To: vvikram@stanford.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 : ipv6 compile failure?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.44.0210092136040.725-100000@epic7.Stanford.EDU>
References: <Pine.GSO.4.44.0210092136040.725-100000@epic7.Stanford.EDU>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Vikram <vvikram@stanford.edu>
   Date: Wed, 9 Oct 2002 21:38:38 -0700 (PDT)

   tried to compile 2.5.41 with ipv6 support , i get the following build
   failure:
...
   apologies if this is redundant.

Known failure fixed in Linus's tree already.

Change the __constant_hto*() to plain hto*() in the case
statements on the lines the compiler complains about.
