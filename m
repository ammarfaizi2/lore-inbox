Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTJRXGf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTJRXGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:06:35 -0400
Received: from line103-242.adsl.actcom.co.il ([192.117.103.242]:29312 "EHLO
	beyondmobile1.beyondsecurity.com") by vger.kernel.org with ESMTP
	id S261895AbTJRXGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:06:32 -0400
From: Aviram Jenik <aviram@beyondsecurity.com>
Organization: Beyond Security Ltd.
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp in test8 fails with intel-agp and i830
Date: Sun, 19 Oct 2003 01:06:13 +0200
User-Agent: KMail/1.5.3
References: <E1AAzPT-0001TY-00@penngrove.fdns.net>
In-Reply-To: <E1AAzPT-0001TY-00@penngrove.fdns.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310190106.14966.aviram@beyondsecurity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 October 2003 00:18, John Mock wrote:
>
>    With vesafb, you should be able to get any resultion you want at
>    60Hz. Which is okay, because you have LCD.
>
> Not necessarily, at least not on a VAIO R505EL  This is due to the well-
> known (to some X hackers at least) 'stolen memory' problem.  

Indeed, the same with my R505DL. I imagine vesafb is not much of a workaround 
for most vaio R505 users :-(

Pavel - I looked in intel_agp and placed printk+mdelay all over 
agp_intel_resume(struct pci_dev *pdev), but something strange happened: I saw 
those print outs during _suspend_ and not during resume - does that make any 
sense?

-- 
Aviram Jenik
Beyond Security Ltd.
http://www.BeyondSecurity.com
http://www.SecuriTeam.com

Know that you're safe:
http://www.AutomatedScanning.com
