Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271710AbRHUOqq>; Tue, 21 Aug 2001 10:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271711AbRHUOqi>; Tue, 21 Aug 2001 10:46:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27550 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271710AbRHUOqV>;
	Tue, 21 Aug 2001 10:46:21 -0400
Date: Tue, 21 Aug 2001 07:46:28 -0700 (PDT)
Message-Id: <20010821.074628.99199050.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15ZCmV-00080q-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15ZCmV-00080q-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Tue, 21 Aug 2001 15:45:26 +0100 (BST)
   
   For the other 99.9% of the userbase we saved 128Kbytes of ram and improved
   reliability by not loading half tested firmeware on them.

We saved nothing, __init_data the firmware, problem solved.

If the firmware was out of date, update it to a known "Qlogic stamp of
approval" version.

Later,
David S. Miller
davem@redhat.com
