Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289186AbSAOQ6e>; Tue, 15 Jan 2002 11:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289188AbSAOQ6Y>; Tue, 15 Jan 2002 11:58:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39844 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289186AbSAOQ6M>;
	Tue, 15 Jan 2002 11:58:12 -0500
Date: Tue, 15 Jan 2002 08:56:38 -0800 (PST)
Message-Id: <20020115.085638.110975446.davem@redhat.com>
To: adam@yggdrasil.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.2/drivers/net/sungem.c uses nonexistant devexit_p
 macro
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201151654.IAA13233@baldur.yggdrasil.com>
In-Reply-To: <200201151654.IAA13233@baldur.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Tue, 15 Jan 2002 08:54:46 -0800

   	linux-2.5.2/drivers/net/sungem.c uses devexit_p, which is not
   currently in 2.5.2.  I understand the purpose of devexit_p and I have
   kludged around it for myself.  I am just bringing it to your attention
   so you can figure out whether to remove the devexit_p reference, have
   a workaround for kernels that lack it, or add devexit_p to Linus's tree.
   
It'll be fixed in 2.5.3, my tree had a whole bunch of 2.4.x stuff in
it which I decided to wipe out because of conflicts like this.

