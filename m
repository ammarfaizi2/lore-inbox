Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUGaWQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUGaWQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 18:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUGaWQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 18:16:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:24764 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264633AbUGaWLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 18:11:34 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <410C12CA.7060109@pobox.com>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <1091226922.5083.13.camel@localhost.localdomain>
	 <1091232770.1677.24.camel@mindpipe>
	 <200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1091297179.1677.290.camel@mindpipe>
	 <1091302522.6910.4.camel@localhost.localdomain>
	 <1091309723.1677.391.camel@mindpipe>  <410C12CA.7060109@pobox.com>
Content-Type: text/plain
Message-Id: <1091311922.1677.428.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 18:12:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 17:44, Jeff Garzik wrote:
> Lee Revell wrote:
> > Even if it's not appropriate for this case, there have to be some places
> > in the kernel where this would be useful.  What about hardware that is 
> > broken, requiring a device-specific kludge?  Hardware that the kernel
> > developers would prefer didn't exist.  There have to be some of these. 
> > Or are most of these already broken out and disabled by default like the
> > old CMD640 ide bug?
> 
> 
> Broken hardware will always exist.  Sounds like you want 
> CONFIG_PERFECT_WORLD ?
> 

Sure.  Got a patch?

Lee

