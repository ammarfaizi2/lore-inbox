Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293380AbSCSAmf>; Mon, 18 Mar 2002 19:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293379AbSCSAmP>; Mon, 18 Mar 2002 19:42:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13758 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293380AbSCSAl7>;
	Mon, 18 Mar 2002 19:41:59 -0500
Date: Mon, 18 Mar 2002 16:38:38 -0800 (PST)
Message-Id: <20020318.163838.29962146.davem@redhat.com>
To: cort@fsmlabs.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020318173635.Q4783@host110.fsmlabs.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Cort Dougan <cort@fsmlabs.com>
   Date: Mon, 18 Mar 2002 17:36:35 -0700

   The structure of the program you suggested with more portable timing.
   
Oh, just something like:


	gettimeofday(&stamp1);
	for (A MILLION TIMES) {
		TLB miss;
	}
	gettimeofday(&stamp2);

Franks a lot,
David S. Miller
davem@redhat.com
