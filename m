Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVBJVI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVBJVI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 16:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVBJVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 16:08:55 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:32491 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261919AbVBJVII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 16:08:08 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kendall Bennett <kendallb@scitechsoft.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
       Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <420BC814.4050102@scitechsoft.com>
References: <1107695583.14847.167.camel@localhost.localdomain>
	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>
	 <1108066096.4085.69.camel@tyrosine>
	 <9e473391050210121756874a84@mail.gmail.com>
	 <1108067388.4085.74.camel@tyrosine>
	 <9e47339105021012341c94c441@mail.gmail.com>
	 <420BC814.4050102@scitechsoft.com>
Date: Thu, 10 Feb 2005 21:06:36 +0000
Message-Id: <1108069596.4085.78.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [RFC] Reliable video POSTing on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 12:46 -0800, Kendall Bennett wrote:

> So perhaps this problem is something similar?

I don't think so - if I dd out of ROM, I get something that looks like a
video BIOS (and, indeed, I can make VBE calls to and from it). The
problem is jumping to c000:0003 and executing - this has the effect of
turning off the backlight and giving an illegal instruction error
(I /think/ - I may be getting the machine I have here confused with one
a tester has...)

-- 
Matthew Garrett | mjg59@srcf.ucam.org

