Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290710AbSBLBg4>; Mon, 11 Feb 2002 20:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290701AbSBLBgr>; Mon, 11 Feb 2002 20:36:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44934 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290710AbSBLBgc>;
	Mon, 11 Feb 2002 20:36:32 -0500
Date: Mon, 11 Feb 2002 17:34:46 -0800 (PST)
Message-Id: <20020211.173446.21927046.davem@redhat.com>
To: sandhya@ittc.ku.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: skb->data bytes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C687074.6090902@ittc.ku.edu>
In-Reply-To: <3C687074.6090902@ittc.ku.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You've corrupted the data therefore you have to correct the checksum
in the TCP header.  You can't just randomly corrupt data and expect
the checksums to still pass.
