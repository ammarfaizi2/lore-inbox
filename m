Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTEGKv3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTEGKv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:51:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27009 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263129AbTEGKv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:51:28 -0400
Date: Wed, 07 May 2003 02:56:26 -0700 (PDT)
Message-Id: <20030507.025626.10317747.davem@redhat.com>
To: helgehaf@aitel.hist.no
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EB8E4CC.8010409@aitel.hist.no>
References: <3EB8DBA0.7020305@aitel.hist.no>
	<1052304024.9817.3.camel@rth.ninka.net>
	<3EB8E4CC.8010409@aitel.hist.no>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Helge Hafting <helgehaf@aitel.hist.no>
   Date: Wed, 07 May 2003 12:49:48 +0200

   David S. Miller wrote:
   > On Wed, 2003-05-07 at 03:10, Helge Hafting wrote:
   > 
   >>2.5.69-mm1 is fine, 2.5.69-mm2 panics after a while even under very
   >>light load.
   > 
   > Do you have AF_UNIX built modular?
   
   No, I compile everything into a monolithic kernel.
   I don't even enable module support.
   
Andrew, color me stumped.  mm2/linux.patch doesn't have anything
really interesting in the networking.  Maybe it's something in
the SLAB and/or pgd/pmg re-slabification changes?
