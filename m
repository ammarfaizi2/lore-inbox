Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWCMHVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWCMHVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 02:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWCMHVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 02:21:24 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:44237 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1751765AbWCMHVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 02:21:23 -0500
Date: Mon, 13 Mar 2006 02:26:54 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Andrew Morton <akpm@osdl.org>, drzeus-list@drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060313072654.GB20569@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Andrew Morton <akpm@osdl.org>,
	drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
References: <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060312145543.194f4dc7.akpm@osdl.org> <20060313041458.GA13605@vrfy.org> <20060313060221.GA20178@neo.rr.com> <20060313062112.GA15720@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313062112.GA15720@vrfy.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some research, and interestingly enough, the ACPI _CID method allows
for compatible IDs even for PCI devices.  These also would present a problem
for the modalias sysfs attribute.

Thanks,
Adam
