Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273424AbSISVRT>; Thu, 19 Sep 2002 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273427AbSISVRT>; Thu, 19 Sep 2002 17:17:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45974 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273424AbSISVRQ>;
	Thu, 19 Sep 2002 17:17:16 -0400
Date: Thu, 19 Sep 2002 14:12:43 -0700 (PDT)
Message-Id: <20020919.141243.117916437.davem@redhat.com>
To: akpm@digeo.com
Cc: taka@valinux.co.jp, alan@lxorguk.ukuu.org.uk, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D8A36A5.846D806@digeo.com>
References: <3D89176B.40FFD09B@digeo.com>
	<20020919.221513.28808421.taka@valinux.co.jp>
	<3D8A36A5.846D806@digeo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Thu, 19 Sep 2002 13:42:13 -0700
   
   Mala's patch will cause quite an expansion
   of kernel size; we would need an implementation which did not
   use inlining.

It definitely belongs in arch/i386/lib/copy.c or whatever,
not inlined.
