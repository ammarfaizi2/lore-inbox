Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbTHSSdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTHSSdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:33:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53007 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S273004AbTHSSTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:19:53 -0400
Date: Tue, 19 Aug 2003 19:19:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Narayan Desai <desai@mcs.anl.gov>, linux-kernel@vger.kernel.org
Subject: Re: weird pcmcia problem
Message-ID: <20030819191948.C23670@flint.arm.linux.org.uk>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Narayan Desai <desai@mcs.anl.gov>, linux-kernel@vger.kernel.org
References: <87u18efpsc.fsf@mcs.anl.gov> <200308190447.h7J4l0Vq004410@turing-police.cc.vt.edu> <200308191816.h7JIGNBC002405@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308191816.h7JIGNBC002405@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Tue, Aug 19, 2003 at 02:16:23PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 02:16:23PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 19 Aug 2003 00:47:00 EDT, Valdis.Kletnieks@vt.edu said:
> 
> > On Mon, 18 Aug 2003 19:34:59 CDT, Narayan Desai <desai@mcs.anl.gov>  said:
> > > Running 2.6.0-test3 (both with and without your recent yenta socket
> > > patches) pcmcia cards present during boot don't show up until they are
> > > removed and reinserted. Once reinserted, they work fine. This only
> 
> > Same issue on 2.6.0-test3-mm2 on a Dell Latitude C840 with a TrueMobile 1150
> > wireless (uses orinoco_cs driver) - card is recognized at boot, and somewhat
> > configured:
> 
> Went to 2.6.0-test3-mm3, and the problem is resolved on my laptop.  Not sure if
> Narayan's machine is using a different "recent Yenta socket patches" than
> what's in -mm3, or if there's something ELSE that made the difference.

That wasn't expected.

Can you provide all the following information please:

- make/model of machine
- type of cardbus bridge (from lspci)
- type of card (pcmcia or cardbus)
- make/model of card
- full kernel dmesg (including yenta, card services messages)
- cardmgr messages from system log

thx.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

