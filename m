Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWC0LNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWC0LNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWC0LNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:13:31 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:44552 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1750884AbWC0LNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:13:31 -0500
Date: Mon, 27 Mar 2006 08:06:00 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic on PC with broken hard drive, after DMA errors
Message-ID: <20060327070559.GA11165@deprecation.cyrius.com>
References: <5Okau-77g-9@gated-at.bofh.it> <440FA916.5070703@shaw.ca> <20060309151459.GD2891@deprecation.cyrius.com> <1141922743.16745.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141922743.16745.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2006-03-09 16:45]:
> > The dying hard drive is quite arbitrary when it comes to showing
> > errors or working fine...
> 
> Ancient known problem. I'd be interested if you can however break
> libata and the PATA IDE patches the same way.

Sorry, but I'm not able to give you more information.  I tried again
several times with PATA and never saw the oops again, so I don't think
trying libata would help since not seeing an oops wouldn't mean
anything at all.  Unless there is a _specific_ way to trigger this bug
("cause much disk IO" isn't enough because it only led to an oops once
out of maybe something like 30-40 tries) I cannot do anything.
-- 
Martin Michlmayr
http://www.cyrius.com/
