Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSHHO6M>; Thu, 8 Aug 2002 10:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSHHO6M>; Thu, 8 Aug 2002 10:58:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60386 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315449AbSHHO6M>;
	Thu, 8 Aug 2002 10:58:12 -0400
Date: Thu, 08 Aug 2002 07:48:53 -0700 (PDT)
Message-Id: <20020808.074853.114346036.davem@redhat.com>
To: ak@suse.de
Cc: laforge@gnumonks.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix HIPQUAD macro in kernel.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020808134113.A2552@wotan.suse.de>
References: <20020808133112.E11828@sunbeam.de.gnumonks.org>
	<20020808134113.A2552@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Thu, 8 Aug 2002 13:41:13 +0200
   
   That change is wrong. IP address should be always in network order
   (=BE) while in kernel.

He's fixing the HIPQUAD ('H' as in 'host') not NIPQUAD ('N' as in
'network') macro.

If you disagree with people using HIPQUAD at all, recommend that
it be deleted.  Until then, it ought to be fixed :-)
