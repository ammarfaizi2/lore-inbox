Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTFIKch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTFIKcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:32:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50834 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261845AbTFIKcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:32:32 -0400
Date: Mon, 09 Jun 2003 03:43:04 -0700 (PDT)
Message-Id: <20030609.034304.52179334.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: willy@debian.org, linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: [PATCH] [3/3] PCI segment support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030609144242.A15283@jurassic.park.msu.ru>
References: <20030609140749.A15138@jurassic.park.msu.ru>
	<1055154054.9884.2.camel@rth.ninka.net>
	<20030609144242.A15283@jurassic.park.msu.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Mon, 9 Jun 2003 14:42:42 +0400

   On Mon, Jun 09, 2003 at 03:20:56AM -0700, David S. Miller wrote:
   > We could just pass the bus self device in this case.
   
   Root buses often do not have the self device, e.g. on alpha.

How can people make PCI config space accesses to them?
