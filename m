Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277718AbRJIFAg>; Tue, 9 Oct 2001 01:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277719AbRJIFA1>; Tue, 9 Oct 2001 01:00:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56714 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277718AbRJIFAT>;
	Tue, 9 Oct 2001 01:00:19 -0400
Date: Mon, 08 Oct 2001 22:00:28 -0700 (PDT)
Message-Id: <20011008.220028.131917699.davem@redhat.com>
To: rgooch@ras.ucalgary.ca
Cc: arjan@fenrus.demon.nl, kravetz@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200110090455.f994tNB22322@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca>
	<20011004.145239.62666846.davem@redhat.com>
	<200110090455.f994tNB22322@vindaloo.ras.ucalgary.ca>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Gooch <rgooch@ras.ucalgary.ca>
   Date: Mon, 8 Oct 2001 22:55:23 -0600

   So what exactly is the difference between our "delayed FPU restore
   upon trap" (which I think of as lazy FPU saving), and the "lazy FP"
   saving in the comments?

Save always on swithching OUT from a task vs. save only when some
different task asks for the FPU.

Franks a lot,
David S. Miller
davem@redhat.com
