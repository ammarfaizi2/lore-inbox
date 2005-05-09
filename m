Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVEINLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVEINLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 09:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVEINLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 09:11:16 -0400
Received: from mail.dif.dk ([193.138.115.101]:37096 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261352AbVEINLL convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 9 May 2005 09:11:11 -0400
Date: Mon, 9 May 2005 15:10:33 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: "aguel.raouf" <aguel.raouf@laposte.net>,
       Linux-Kernel <Linux-Kernel@vger.kernel.org>
Subject: Re: Raouf From Tunisia
In-Reply-To: <Pine.LNX.4.61.0505090729440.27328@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0505091509280.9393@jjulnx.backbone.dif.dk>
References: <IG7S3H$ECDE8351FD5BB869516C40901B57C29E@laposte.net>
 <Pine.LNX.4.61.0505090729440.27328@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Richard B. Johnson wrote:

> Date: Mon, 9 May 2005 07:31:08 -0400 (EDT)
> From: Richard B. Johnson <linux-os@analogic.com>
> To: aguel.raouf <aguel.raouf@laposte.net>
> Cc: Linux-Kernel <Linux-Kernel@vger.kernel.org>
> Subject: Re: Raouf From Tunisia
> 
> On Mon, 9 May 2005, aguel.raouf wrote:
> > 
> > Hi
> > 
> > 
> > I must modify my distro to not test the status of root
> > directory  (whether it is (is not) writable). For example,
> > Slackware is testing the status of the root partition during
> > boot and if it's read-write,it will display a message and will
> > wait for user input. This is something we don't like, right?
> > Unionfs can't be remounted ro, to skip the test. i will need
> > to do something for my distro.
> > I want to know what i can do, how i can patch my distro
> > 
> > thanks have a good day
> > 
> > Accédez au courrier électronique de La Poste : www.laposte.net ;
> > 3615 LAPOSTENET (0,34EUR/mn) ; tél : 08 92 68 13 50 (0,34EUR/mn)
> > 
> Not a kernel question. File /etc/rc.sysinit is the init script
> that is executed during startup.

Actually, on Slackware, it's /etc/rc.d/rc.S

-- 
Jesper Juhl

