Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSIPXFq>; Mon, 16 Sep 2002 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263323AbSIPXFq>; Mon, 16 Sep 2002 19:05:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11752 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263321AbSIPXFp>;
	Mon, 16 Sep 2002 19:05:45 -0400
Date: Mon, 16 Sep 2002 16:01:43 -0700 (PDT)
Message-Id: <20020916.160143.58808148.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org,
       ebtables-user@lists.sourceforge.net, bridge@math.leidenuniv.nl
Subject: Re: [PATCH] ebtables - Ethernet bridge tables, for 2.5.35
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209160850.16192.bart.de.schuymer@pandora.be>
References: <200209130812.27093.bart.de.schuymer@pandora.be>
	<20020912.230916.96754743.davem@redhat.com>
	<200209160850.16192.bart.de.schuymer@pandora.be>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Mon, 16 Sep 2002 08:50:16 +0200

   The following link points to the ebtables patch approved by Lennert:
   http://users.pandora.be/bart.de.schuymer/ebtables/v2.0/ebtables-v2.0_vs_2.5.35-try3.diff

I'm applying this, but please in the future do not put these
"*** deal with blah blah" seperators in one big patch file.

Give me one bug patch I can just do a clean "patch -p1 <your_patch"
with, thanks.

Sure it's just noise and patch perhaps knows how to skip over it, but
lots of other patch reading tools might not be able to. (for example
diffstat gives a lot of different paths as the patch base directory
because you've done the patch this way).
