Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291562AbSBAGDa>; Fri, 1 Feb 2002 01:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291563AbSBAGDK>; Fri, 1 Feb 2002 01:03:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:131 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291562AbSBAGDD>;
	Fri, 1 Feb 2002 01:03:03 -0500
Date: Thu, 31 Jan 2002 22:01:21 -0800 (PST)
Message-Id: <20020131.220121.39157969.davem@redhat.com>
To: kaos@ocs.com.au
Cc: garzik@havoc.gtf.org, alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <26189.1012540213@kao2.melbourne.sgi.com>
In-Reply-To: <20020131.202509.78710127.davem@redhat.com>
	<26189.1012540213@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Fri, 01 Feb 2002 16:10:13 +1100
   
   As long as Makefiles control initialization order, you need monolithic
   Makefiles.

With the current 2.5.x scheme, you can put your init into the
appropriate group.  Makefiles only control init order within
the groups.

I actually like this solution a lot.
