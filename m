Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTIQQmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbTIQQmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:42:03 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43944 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262601AbTIQQmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:42:01 -0400
Subject: Re: Changes in siimage driver?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <oprvnjyf2oq1sf88@mail.broadpark.no>
References: <oprvnjyf2oq1sf88@mail.broadpark.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063816835.12648.90.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Wed, 17 Sep 2003 17:40:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-17 at 17:26, Arve Knudsen wrote:
> X66 etc.) with hdparm, I get ~50MB/S. It's not an ideal solution since now 
> and then I get a bunch of "disabling irq #18" messages after running 
> hdparm (I think, its part of the startup scripts), and I have to restart.

That is a bug in the 2.6.0 core still. Just hack out the code which does
the IRQ disable on too many apparently unidentified interrupts.

> directories. Am I the only one who's run into any sort of issues with the 
> updated driver? From what I can see it hasn't been modified in the last 
> revision (test5-bk4), hopefully noone is losing important data because of 
> this (fortunately I had some recent backups). Anyway, I'd like some 
> feedback on this from those in the know (the performance drop should be 
> fairly easy to verify, unless hdparm is playing tricks on me).

Don't keep important data only on 2.6-test boxes. Its 'test' - it
shouldnt eat anything but...

