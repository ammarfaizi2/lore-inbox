Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUGaVpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUGaVpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUGaVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:45:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56729 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264519AbUGaVpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:45:08 -0400
Message-ID: <410C12CA.7060109@pobox.com>
Date: Sat, 31 Jul 2004 17:44:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>	 <1091226922.5083.13.camel@localhost.localdomain>	 <1091232770.1677.24.camel@mindpipe>	 <200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>	 <1091297179.1677.290.camel@mindpipe>	 <1091302522.6910.4.camel@localhost.localdomain> <1091309723.1677.391.camel@mindpipe>
In-Reply-To: <1091309723.1677.391.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Even if it's not appropriate for this case, there have to be some places
> in the kernel where this would be useful.  What about hardware that is 
> broken, requiring a device-specific kludge?  Hardware that the kernel
> developers would prefer didn't exist.  There have to be some of these. 
> Or are most of these already broken out and disabled by default like the
> old CMD640 ide bug?


Broken hardware will always exist.  Sounds like you want 
CONFIG_PERFECT_WORLD ?

	Jeff


