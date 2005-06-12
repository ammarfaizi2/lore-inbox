Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVFLNLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVFLNLI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVFLNLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:11:08 -0400
Received: from one.firstfloor.org ([213.235.205.2]:17635 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262308AbVFLNLB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:11:01 -0400
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       subbie subbie <subbie_subbie@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: optional delay after partition detection at boot time
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com>
	<20050612071213.GG28759@alpha.home.local>
	<Pine.LNX.4.62.0506121225170.11197@numbat.sonytel.be>
	<20050612110539.GA9765@gallifrey>
	<20050612111659.GH28759@alpha.home.local>
	<20050612125447.GD9765@gallifrey>
From: Andi Kleen <ak@muc.de>
Date: Sun, 12 Jun 2005 15:10:59 +0200
In-Reply-To: <20050612125447.GD9765@gallifrey> (David Alan Gilbert's message
 of "Sun, 12 Jun 2005 13:54:47 +0100")
Message-ID: <m1fyvnd8kc.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. David Alan Gilbert" <dave@treblig.org> writes:
>
> 1) could be cured by not actually panic'ing.

Actually one thing I always wanted was to make sysrq still work 
after panic. Then you could add a key to page through the dmesg
there too and the problem would be solved.

It would be extremly useful to reset remote servers when panic=timeout
is not set, but something went wrong with mounting /.

-Andi

