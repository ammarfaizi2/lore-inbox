Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269612AbTGaVcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTGaVcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:32:17 -0400
Received: from AMarseille-201-1-5-189.w217-128.abo.wanadoo.fr ([217.128.250.189]:29223
	"EHLO gaston") by vger.kernel.org with ESMTP id S269623AbTGaVbW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:31:22 -0400
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20030731140908.GB16463@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
	 <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>
	 <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net>
	 <20030731094231.GA464@elf.ucw.cz> <3F291B9E.10109@pacbell.net>
	 <20030731140908.GB16463@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059687033.2417.164.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 23:30:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For what kind of I/O? I do not see a reason for disk to veto
> suspend. CD-burner might want to do that, but it still would be bad
> idea... (Running on battery, battery goes low, and you destroy your CD
> *and* your filesystem.

Well... that's userland policy. You can have a notion of "severity" of
the suspend request, like vetoing a user-requested suspend request but
not one issuing from a very-low-battery warning...

This is a part of the PM playfield that still is mostly to be done...

Ben.

