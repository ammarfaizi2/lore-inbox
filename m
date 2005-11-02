Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbVKBJrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbVKBJrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVKBJrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:47:37 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:62667 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S932698AbVKBJrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:47:36 -0500
Date: Wed, 2 Nov 2005 10:48:22 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Ben Dooks <ben@fluff.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, vojtech@suse.cz, rpurdie@rpsys.net,
       lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102104822.552b3971@inspiron>
In-Reply-To: <20051102024755.GA14148@home.fluff.org>
References: <20051101234459.GA443@elf.ucw.cz>
	<20051102024755.GA14148@home.fluff.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005 02:47:55 +0000
Ben Dooks <ben@fluff.org.uk> wrote:

> > I think even slow blinking was used somewhere. I have some code from
> > John Lenz (attached); it uses sysfs interface, exports led collor, and
> > allows setting different frequencies.
> > 
> > Is that acceptable, or should some other interface be used?
> 
> there is already an LED interface for linux-arm, which is
> used by a number of the extant machines in the sa11x0 and
> pxa range.

 Hello,

   the current interface is very low-level, while the proposal
 from Pavel/John has a much different scope, imho.
 
  I'm working on a led driver for the ixp4xx/NSLU2 which
 has 2 leds plus a multi-coloured one. 

  We would benefit a lot from such an implementation so,
 FWIW, I express my personal support and the one
 of the whole nslu2-linux community. 

  Once this patch is upstream, the linux-arm interface could easily 
 be adapted to use it or cooperate nicely.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

