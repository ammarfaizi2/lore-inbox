Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290736AbSBLCqi>; Mon, 11 Feb 2002 21:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290729AbSBLCqX>; Mon, 11 Feb 2002 21:46:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24455 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290736AbSBLCqH> convert rfc822-to-8bit;
	Mon, 11 Feb 2002 21:46:07 -0500
Date: Mon, 11 Feb 2002 18:44:12 -0800 (PST)
Message-Id: <20020211.184412.35663889.davem@redhat.com>
To: groudier@free.fr
Cc: alan@lxorguk.ukuu.org.uk, zaitcev@redhat.com, stodden@in.tum.de,
        linux-kernel@vger.kernel.org
Subject: Re: pci_pool reap?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020210211352.Q1910-100000@gerard>
In-Reply-To: <E16a6sw-0005Jw-00@the-village.bc.nu>
	<20020210211352.Q1910-100000@gerard>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Sun, 10 Feb 2002 21:20:05 +0100 (CET)

   On Mon, 11 Feb 2002, Alan Cox wrote:
   
   > This function may not be called in interrupt context.
   
   Such limitation looks poor implementation to me.

I agree with you Gerard, and probably nobody truly even requires
this limitation.  I do plan to remove it after I've done a thorough
investigation of the platform implementations.
