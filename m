Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSHDAlt>; Sat, 3 Aug 2002 20:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318069AbSHDAlt>; Sat, 3 Aug 2002 20:41:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21683 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318045AbSHDAls>;
	Sat, 3 Aug 2002 20:41:48 -0400
Date: Sat, 03 Aug 2002 17:32:04 -0700 (PDT)
Message-Id: <20020803.173204.16064200.davem@redhat.com>
To: torvalds@transmeta.com
Cc: frankeh@watson.ibm.com, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208031237060.9758-100000@home.transmeta.com>
References: <200208031441.29353.frankeh@watson.ibm.com>
	<Pine.LNX.4.44.0208031237060.9758-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sat, 3 Aug 2002 12:39:40 -0700 (PDT)
   
   And the way David did coloring a long time ago (if
   I remember his implementation correctly) was the same way you'd do
   superpages: just do higher order allocations.
   
Although it wasn't my implementation which did this,
one of them did do it this way.  I agree that it is
the nicest way to do coloring.
