Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267884AbUGaAMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267884AbUGaAMh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 20:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUGaAMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 20:12:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:20668 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267876AbUGaAM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 20:12:28 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <1091226922.5083.13.camel@localhost.localdomain>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <1091226922.5083.13.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1091232770.1677.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 20:12:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 18:35, Alan Cox wrote:
> On Gwe, 2004-07-30 at 20:11, Todd Poynor wrote:
> > IDE initialization and probing makes numerous calls to sleep for 50
> > milliseconds while waiting for the interface to return probe status and
> > such. 
> 
> Please make it taint the kernel if you do that so we can ignore all the
> bug reports. That or justify it with a cite from the ATA standards ?
> 

Works great on my hardware.  Well worth the savings in boot time.

Lee

