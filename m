Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261552AbSJNNTZ>; Mon, 14 Oct 2002 09:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSJNNTZ>; Mon, 14 Oct 2002 09:19:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29337 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261552AbSJNNTZ>;
	Mon, 14 Oct 2002 09:19:25 -0400
Date: Mon, 14 Oct 2002 06:18:14 -0700 (PDT)
Message-Id: <20021014.061814.06551321.davem@redhat.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support,
 2.5.42-F8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210141525250.21947-100000@localhost.localdomain>
References: <20021014.054500.89132620.davem@redhat.com>
	<Pine.LNX.4.44.0210141525250.21947-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Mon, 14 Oct 2002 15:30:42 +0200 (CEST)
   
   Where to draw the line between a loop of INVLPG and a CR3 flush on
   x86 is up in the air - i'd say it's at roughly 8 pages currently

I'd say it's highly x86 revision dependant and that it
can be easily calibrated at boot time :-)
