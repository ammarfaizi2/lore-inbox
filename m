Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319077AbSIDGVV>; Wed, 4 Sep 2002 02:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319078AbSIDGVV>; Wed, 4 Sep 2002 02:21:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20443 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319077AbSIDGVV>;
	Wed, 4 Sep 2002 02:21:21 -0400
Date: Tue, 03 Sep 2002 23:19:07 -0700 (PDT)
Message-Id: <20020903.231907.21327801.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020903.230607.24231380.davem@redhat.com>
References: <20020903.220514.21399526.davem@redhat.com>
	<20020904060105.C263E2C1B6@lists.samba.org>
	<20020903.230607.24231380.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually Rusty what's the big deal, add an "initializer"
arg to the macro.  It doesn't hurt anyone, it doesn't lose
any space in the kernel image, and the macro arg reminds
people to do it.

I think it's a small price to pay to keep a longer range
of compilers supported :-)
