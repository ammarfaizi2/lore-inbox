Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUAJDEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAJDEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:04:20 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:53123
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264542AbUAJDES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:04:18 -0500
Date: Fri, 9 Jan 2004 22:17:00 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup with 2.6.0
Message-ID: <20040109221700.A8686@animx.eu.org>
References: <20040109104955.B6840@animx.eu.org> <Pine.LNX.4.44.0401091653340.19686-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.44.0401091653340.19686-100000@poirot.grange>; from Guennadi Liakhovetski on Fri, Jan 09, 2004 at 05:02:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Are sysrq-keys enabled? If so, could you catch the tar backtrace during
> > > the lock-up (ALT-SysRq-t)? What was the latest kernel-version that worked?
> >
> > Yes, but the machine hard locks.  sysrq does not work.  I have a small
> 
> __THAT__ hard...:-)

I'm pretty sure I found the problem.  (well, it hasn't locked yet).  The CPU
voltage was set at 2.00v in the bios, now it's at 1.65v and I'm not having
any lockups.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
