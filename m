Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVFAKjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFAKjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 06:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFAKjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 06:39:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:64445 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261179AbVFAKjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 06:39:07 -0400
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601090622.GB6693@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston>
	 <20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston>
	 <20050531212556.GA14968@elf.ucw.cz> <1117582309.5826.60.camel@gaston>
	 <20050601081336.GA6693@elf.ucw.cz> <1117614857.19020.32.camel@gaston>
	 <20050601090622.GB6693@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 20:38:39 +1000
Message-Id: <1117622320.19020.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, but that means that we can get those "please don't use these
> callbacks if you can avoid it" messages, right :-).

Heh, well, I'll look if I can do something more specific to APM emu
there, maybe I'll find time to just switch over to a generic
implementation.

> Seems like lots of stuff is going to happen in pm post-2.6.12: I'd
> like to finally fix pm_message_t, too...

Yup. I have a couple of driver patches fixing things in this area too.

Ben.


