Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSJAXTB>; Tue, 1 Oct 2002 19:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262279AbSJAXSB>; Tue, 1 Oct 2002 19:18:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62912 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262910AbSJAXRa>;
	Tue, 1 Oct 2002 19:17:30 -0400
Date: Tue, 01 Oct 2002 16:15:54 -0700 (PDT)
Message-Id: <20021001.161554.66190770.davem@redhat.com>
To: mau@oscar.prima.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: LMbench results for 2.5.40
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021001220853.GA20022@oscar.dorf.de>
References: <20021001220853.GA20022@oscar.dorf.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Mau <mau@oscar.prima.de>
   Date: Wed, 2 Oct 2002 00:08:54 +0200
   
   Could someone explain the results I marked with '???' ?
   The ones under 'Local Communication Bandwidth'.

It's due to debugging code in the loopback net driver.
It copies every TCP data packet twice.  This will go away
before the 2.6 release.
