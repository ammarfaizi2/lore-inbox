Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSIZVN1>; Thu, 26 Sep 2002 17:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSIZVN1>; Thu, 26 Sep 2002 17:13:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33930 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261528AbSIZVN0>;
	Thu, 26 Sep 2002 17:13:26 -0400
Date: Thu, 26 Sep 2002 14:12:23 -0700 (PDT)
Message-Id: <20020926.141223.128110378.davem@redhat.com>
To: jgarzik@pobox.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [RFC] {read,write}s{b,w,l} or iobarrier_*()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D93348D.3060304@pobox.com>
References: <20020926155941.3602@192.168.4.1>
	<3D93348D.3060304@pobox.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Thu, 26 Sep 2002 12:23:41 -0400

   Benjamin Herrenschmidt wrote:
   >  - Have all archs provide {read,write}s{b,w,l} functions.
   > Those will hide all of the details of bytewapping & barriers
   > from the drivers and can be used as-is for things like IDE
   > MMIO iops.
   
   I prefer this solution...

I'm starting to think about taking back all the previous
arguments I had against this idea.  It's starting to sound
like the preferred way to go.
