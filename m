Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWGAHVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWGAHVe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 03:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWGAHVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 03:21:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:13722 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932523AbWGAHVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 03:21:33 -0400
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux powerpc <linuxppcleo@gmail.com>
Cc: Rune Torgersen <runet@innovsys.com>, Li Yang-r58472 <LeoLi@freescale.com>,
       linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <a0bc9bf80606302335p7ba227afwf69dc42e2eada64b@mail.gmail.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	 <1151709194.27137.2.camel@localhost.localdomain>
	 <DCEAAC0833DD314AB0B58112AD99B93B07B36E@ismail.innsys.innovsys.com>
	 <a0bc9bf80606302335p7ba227afwf69dc42e2eada64b@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 17:21:06 +1000
Message-Id: <1151738466.27137.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 14:35 +0800, Linux powerpc wrote:
> Yes, it was used for allocating dual port RAM for CPM.  And now we are
> adding QE support to powerpc arch which need to use rheap(QE is next
> generation for CPM).  Please see the patches I <leoli@freescale.com>
> just posted for 8360epb support.  Moreover, previous CPM support is
> adding to powerpc arch too. 

Ok, well, I don't have anything specifically against that code, I was
just wondering if it may not duplicate something we already have (yet
another space allocator basically)... 

Ben.


