Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278578AbRJXP3d>; Wed, 24 Oct 2001 11:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278572AbRJXP3X>; Wed, 24 Oct 2001 11:29:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19850 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278568AbRJXP3J>;
	Wed, 24 Oct 2001 11:29:09 -0400
Date: Wed, 24 Oct 2001 08:29:25 -0700 (PDT)
Message-Id: <20011024.082925.68578636.davem@redhat.com>
To: baggins@sith.mimuw.edu.pl
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: acenic breakage in 2.4.13-pre
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011024164533.C15474@sith.mimuw.edu.pl>
In-Reply-To: <20011024164533.C15474@sith.mimuw.edu.pl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
   Date: Wed, 24 Oct 2001 16:45:33 +0200
   
   Speaking of acenic - it's broken in 2.4.13-pre. I have 3c985 and all I
   get with 2.4.13-pre is "Firmware NOT running!". After I backed the
   changes from -pre patch it started and works fine. Maybe the problem is
   I have it in 32bit PCI slot?

Do you have CONFIG_HIGHMEM enabled?  If so, please try with
it turned off.

Franks a lot,
David S. Miller
davem@redhat.com
