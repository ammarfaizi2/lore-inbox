Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279416AbRKIGFX>; Fri, 9 Nov 2001 01:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279418AbRKIGFN>; Fri, 9 Nov 2001 01:05:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28033 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279416AbRKIGFC>;
	Fri, 9 Nov 2001 01:05:02 -0500
Date: Thu, 08 Nov 2001 22:04:44 -0800 (PST)
Message-Id: <20011108.220444.95062095.davem@redhat.com>
To: ak@suse.de
Cc: anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011109064540.A13498@wotan.suse.de>
In-Reply-To: <p731yj8kgvw.fsf@amdsim2.suse.de>
	<20011109110532.B6822@krispykreme>
	<20011109064540.A13498@wotan.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 9 Nov 2001 06:45:40 +0100
   
   Sounds like you need a better hash function instead.
   
Andi, please think about the problem before jumping to conclusions.
N_PAGES / N_CHAINS > 1 in his situation.  A better hash function
cannot help.

Franks a lot,
David S. Miller
davem@redhat.com
