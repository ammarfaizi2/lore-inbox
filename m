Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbSIWS7X>; Mon, 23 Sep 2002 14:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbSIWS6b>; Mon, 23 Sep 2002 14:58:31 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:21465 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261367AbSIWS5d>;
	Mon, 23 Sep 2002 14:57:33 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.25940.171044.146270@napali.hpl.hp.com>
Date: Mon, 23 Sep 2002 12:02:44 -0700
To: Matt Porter <porter@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can we drop early_serial_setup()?
In-Reply-To: <20020921064504.A31995@home.com>
References: <200209200459.g8K4xJcW011057@napali.hpl.hp.com>
	<20020920163357.A30546@home.com>
	<15755.44527.146016.975532@napali.hpl.hp.com>
	<20020921064504.A31995@home.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 21 Sep 2002 06:45:04 -0700, Matt Porter <porter@cox.net> said:

  Matt> That will be fine then.  I misconstrued your first statements
  Matt> as indicating that we should duplicate this code in each arch
  Matt> (which I didn't like).  As far as PPC is concerned, go ahead
  Matt> and wipe out early_serial_setup when you bring in
  Matt> early_register_port.

  Matt> FWIW, there's actually been more PPC platforms than ev64260
  Matt> using early_serial_setup. They had abandoned it temporarily
  Matt> for a less flexible approach due to the breakage.

OK, thanks for confirming.

	--david
