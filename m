Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTEFFJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 01:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTEFFJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 01:09:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43236 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262360AbTEFFJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 01:09:57 -0400
Date: Mon, 05 May 2003 21:14:59 -0700 (PDT)
Message-Id: <20030505.211459.21913657.davem@redhat.com>
To: miles@gnu.org, miles@lsi.nec.co.jp
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850] Add leading underline to new linker-script
 symbols on the v850
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <buohe88slo7.fsf@mcspd15.ucom.lsi.nec.co.jp>
References: <20030506030925.388CC3760@mcspd15.ucom.lsi.nec.co.jp>
	<1052192261.983.10.camel@rth.ninka.net>
	<buohe88slo7.fsf@mcspd15.ucom.lsi.nec.co.jp>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Miles Bader <miles@lsi.nec.co.jp>
   Date: 06 May 2003 14:12:40 +0900
   
   I think in this case it's because I try to keep the v850 arch files
   identical on 2.4.x and 2.5.x (as much as is possible), which sometimes
   results in unused #defines on one or the other.

Please don't do that, 2.4.x and 2.5.x are different kernel.
There will be differences, just accept them.

Some of us use grepping tools to see if arch's depend upon
deleted interfaces still existing, and once we start adding
exceptions such as yours the tools become less and less useful.

Therefore, please delete the flush_page_to_ram define on v850.
Thank you.
