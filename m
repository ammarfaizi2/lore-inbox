Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTDYJtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 05:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTDYJtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 05:49:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23687
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263535AbTDYJtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 05:49:31 -0400
Subject: Re: [PATCH] aha1740 update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mzyngier@freesurf.fr
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <wrpptnasxwd.fsf@hina.wild-wind.fr.eu.org>
References: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>
	 <1051210184.4005.12.camel@dhcp22.swansea.linux.org.uk>
	 <wrpptnasxwd.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051261371.5459.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Apr 2003 10:02:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-25 at 10:56, Marc Zyngier wrote:
> >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> Alan> The AHA1740 has firmware handled abort/reset handling. The "head
> Alan> in sand" kernel code is correct for once 8)
> 
> That's nice ! :-) Is there any way to stop the kernel from screaming
> each time the module loads ? Would defining a dummy abort handler
> work ?

The kernel screaming is a debug thing. A dummy handler looks like it will
do the trick nicely

