Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSIXG3G>; Tue, 24 Sep 2002 02:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSIXG3G>; Tue, 24 Sep 2002 02:29:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41151 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261582AbSIXG3G>;
	Tue, 24 Sep 2002 02:29:06 -0400
Date: Mon, 23 Sep 2002 23:24:13 -0700 (PDT)
Message-Id: <20020923.232413.08022213.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] streq() 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020924061722.688A32C0A6@lists.samba.org>
References: <Pine.LNX.4.44.0209240731060.8824-100000@localhost.localdomain>
	<20020924061722.688A32C0A6@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Tue, 24 Sep 2002 16:04:33 +1000
   
   For runtime checks (which are never as good) you could change the GFP_
   defined to set the high bit.

Another idea is to make a gfp_flags_t, that worked very well
for things like mm_segment_t.

