Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266515AbUBQUf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUBQUf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:35:58 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:8091 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266515AbUBQUf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:35:56 -0500
X-BrightmailFiltered: true
Date: Tue, 17 Feb 2004 21:36:04 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
Subject: Re: Radeonfb problem
Message-ID: <20040217203604.GA19110@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402172008.39887.vergata@stud.fbi.fh-darmstadt.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de> ha scritto:
> I'v 2.6.3-rc3-mm1 up and running on an t40p.
> ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 02)
> The problem i observe was that reset won't clean my display just draw the new 
> commandline on the upper left. The screen still old display. 

Are you running X? This is a known problem, it's X fiddling with accel
registers. BenH is working on a fix, for now you can boot with "noaccel"
to disable hw acceleration.

Btw, how does 2.6.3-rc4 work?

Luca
-- 
Home: http://kronoz.cjb.net
Ligabue canta: "Tutti vogliono viaggiare in primaaaa..."
Io ci ho provato e dopo un chilometro ho fuso il motore e bruciato
la frizione...
