Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTLDSrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTLDSrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:47:07 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:7838 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263486AbTLDSrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:47:00 -0500
Date: Thu, 4 Dec 2003 19:46:56 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031204184656.GC14029@wohnheim.fh-wedel.de>
References: <20031203143122.GA6470@wohnheim.fh-wedel.de> <20031203100709.B6625@sonic.net> <20031203190440.GA15857@wohnheim.fh-wedel.de> <20031203225743.A25889@flint.arm.linux.org.uk> <20031204150846.GJ1117@admingilde.org> <20031204184032.D31675@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031204184032.D31675@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 December 2003 18:40:32 +0000, Russell King wrote:
> 
> Oddly that's what I have been doing, but we've run out of time to
> completely eliminate the recursions in PCMCIA before the 2.6 brakes
> were turned on.  Sure, if someone wants to try submitting a PCMCIA
> rewrite to Linus right now and wants to receive Linus' flames, go
> ahead. 8)
> 
> So, for the time being, live with the fact that current automated
> program analysis detects the recusion.  Inteligent human examination
> will tell you that it can't infinitely recurse.

Thank you!  "Not yet" is perfectly acceptable to me. :)

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979
