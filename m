Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUA2Aj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 19:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266272AbUA2Aj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 19:39:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:6374 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266271AbUA2Aj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 19:39:27 -0500
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugang <hugang@soulinfo.com>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040128202217.0a1f8222@localhost>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
	 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
	 <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost>
	 <1074912854.834.61.camel@gaston> <20040126181004.GB315@elf.ucw.cz>
	 <1075154452.6191.91.camel@gaston> <1075156310.2072.1.camel@laptop-linux>
	 <20040128202217.0a1f8222@localhost>
Content-Type: text/plain
Message-Id: <1075336478.30623.317.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 11:34:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-28 at 23:22, Hugang wrote:
> On Tue, 27 Jan 2004 11:31:50 +1300
> Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
> 
> > Yes. That's why suspend2 doesn't free any memory at all by default,
> > but gives the user the option of setting a maximum image size.
> 
> HaHa, Here is swsusp2 patch for ppc. Now it WORKS fine.
> 
> The code base for testing, any comments and testing are welcome.

Ok, had a quick look. I  _HATE_ those horrible macros you did. Why
not just call asm functions or just inline the code ?

Ben.


