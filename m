Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTDVSNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbTDVSNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:13:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28681 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263322AbTDVSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:13:40 -0400
Date: Tue, 22 Apr 2003 19:25:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Pau Aliagas <linuxnow@newtral.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.67
Message-ID: <20030422192542.C31709@flint.arm.linux.org.uk>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Pau Aliagas <linuxnow@newtral.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304221722160.1536-100000@pau.intranet.ct> <200304221703.h3MH3ILq002147@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304221703.h3MH3ILq002147@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Tue, Apr 22, 2003 at 01:03:17PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 01:03:17PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 22 Apr 2003 17:28:18 +0200, Pau Aliagas <linuxnow@newtral.org>  said:
> 
> > I have a Dell Latitude Laptop with a Xircom Cardbus ethernet + modem card.
> > If I boot with the card inserted booting stops like this:
> > ........
> > socket status = 30000006
> 
> That's a known bug with pcmcia - Russel posted a fix which seems to be in:
> 
>   http://patches.arm.linux.org.uk/pcmcia-20030421.diff

Linus isn't particularly enthralled with the fix there, so I'm working on
a replacement version.  (Hell, I'm not that happy with that fix either,
but it does fix the problem.)

The replacement version is something I was planning on doing anyway, just
that its happening earlier than I really wanted it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

