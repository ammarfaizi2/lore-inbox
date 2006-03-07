Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWCGTDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWCGTDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCGTDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:03:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54219 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751187AbWCGTDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:03:44 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, alan@redhat.com, gregkh@kroah.com
In-Reply-To: <200603070903.19226.dsp@llnl.gov>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603061014.22312.dsp@llnl.gov>
	 <20060306102232.613911f6.rdunlap@xenotime.net>
	 <200603070903.19226.dsp@llnl.gov>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 20:03:38 +0100
Message-Id: <1141758219.3048.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was initially a bit confused because I thought the comment
> specifically pertained to the piece of code shown above.  I need to
> take a closer look at the EDAC sysfs code - I'm not as familiar with
> some of its details as I should be.  Thanks for pointing out the
> issue.

afaics it is a list of pci devices. these should just be symlinks to the
sysfs resource of these pci devices instead, not a flat table file.


