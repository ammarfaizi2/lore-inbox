Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278004AbRJ3UoU>; Tue, 30 Oct 2001 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278038AbRJ3UoK>; Tue, 30 Oct 2001 15:44:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59523 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278004AbRJ3Un5>;
	Tue, 30 Oct 2001 15:43:57 -0500
Date: Tue, 30 Oct 2001 12:44:30 -0800 (PST)
Message-Id: <20011030.124430.66056222.davem@redhat.com>
To: guus@warande3094.warande.uu.nl
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Fix check if device is ethernet in alloc_divert_blk
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011030162235.B5566@sliepen.warande.net>
In-Reply-To: <20011030162235.B5566@sliepen.warande.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Guus Sliepen <guus@warande3094.warande.uu.nl>
   Date: Tue, 30 Oct 2001 16:22:35 +0100
   
   Instead of checking for the actual device type, alloc_divert_blk was
   just checking if the string "eth" occured in the name of the interface.
   Attached patch makes it do the right thing instead (I hope).

I've applied your patch.

Franks a lot,
David S. Miller
davem@redhat.com
