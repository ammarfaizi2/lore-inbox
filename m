Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSI3AXB>; Sun, 29 Sep 2002 20:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSI3AXB>; Sun, 29 Sep 2002 20:23:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4523 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261859AbSI3AXA>;
	Sun, 29 Sep 2002 20:23:00 -0400
Date: Sun, 29 Sep 2002 17:21:36 -0700 (PDT)
Message-Id: <20020929.172136.79546522.davem@redhat.com>
To: ak@suse.de
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p733crssjdl.fsf@oldwotan.suse.de>
References: <20020929152731.GA10631@averell.suse.lists.linux.kernel>
	<20020929182643.C8564@infradead.org.suse.lists.linux.kernel>
	<p733crssjdl.fsf@oldwotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 29 Sep 2002 21:09:26 +0200
   
   No, with gcc 3.2 it doesn't seem to make much difference.

Because -fno-strict-aliasing is still in CFLAGS.  Your
change is pointless until that situation changes.
