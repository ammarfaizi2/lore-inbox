Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSIEG1D>; Thu, 5 Sep 2002 02:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSIEG1D>; Thu, 5 Sep 2002 02:27:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64741 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317096AbSIEG1C>;
	Thu, 5 Sep 2002 02:27:02 -0400
Date: Wed, 04 Sep 2002 23:24:25 -0700 (PDT)
Message-Id: <20020904.232425.10994370.davem@redhat.com>
To: bof@bof.de
Cc: rusty@rustcorp.com.au, ak@suse.de, laforge@gnumonks.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack_hash() problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905082128.D19551@oknodo.bof.de>
References: <20020904152626.A11438@wotan.suse.de>
	<20020905044436.0772A2C0DF@lists.samba.org>
	<20020905082128.D19551@oknodo.bof.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Schaaf <bof@bof.de>
   Date: Thu, 5 Sep 2002 08:21:28 +0200

   B) I despise the (1 << ...htable_bits) construct, used in several places.
      It's nothing but obfuscation. Please reinstate ...htable_size, and
      use that, the code will be more readable.

You despise, but the processor doesn't.  Less data loads
means the code goes faster.

Franks a lot,
David S. Miller
davem@redhat.com
