Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRFGFum>; Thu, 7 Jun 2001 01:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263412AbRFGFuc>; Thu, 7 Jun 2001 01:50:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49038 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262288AbRFGFuY>;
	Thu, 7 Jun 2001 01:50:24 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15135.5661.601195.943992@pizda.ninka.net>
Date: Wed, 6 Jun 2001 22:50:21 -0700 (PDT)
To: "George Bonser" <george@gator.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <CHEKKPICCNOGICGMDODJMECLDEAA.george@gator.com>
In-Reply-To: <15134.53268.965680.167845@pizda.ninka.net>
	<CHEKKPICCNOGICGMDODJMECLDEAA.george@gator.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


George Bonser writes:
 > There is, of course, one basic problem with that argument. While you can say
 > (and probably rightly so) that such a change would not be included in Linus'
 > kernel, I think anyone is allowed to post a patch that might make it
 > possible to add protocols as modules. If anyone chooses to use it is each
 > individual's decision but you could not prevent ACME from creating a patch
 > that allows protocol modules as long as they distributed the patch. Also,  I
 > know that you are allowed to distribute proprietary modules in binary form
 > but are there any restrictions on what function these modules can perform?
 > I don't remember seeing any such restrictions.

People can post whatever patches which do whatever, sure.
But this isn't what matters.

What matters is the API under which a binary-only module may interface
to the kernel.  Linus specifies that only the module exports in his
tree fall into this API.

As I stated in another email, the allowance of binary-only kernel
modules is a special exception to the licensing of the kernel made by
Linus.  The GPL by itself, does not allow this at all.

Later,
David S. Miller
davem@redhat.com

