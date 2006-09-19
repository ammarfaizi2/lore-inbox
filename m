Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWISUDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWISUDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWISUDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:03:16 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:65242 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750830AbWISUDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:03:15 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Lee Revell <rlrevell@joe-job.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Drake <dsd@gentoo.org>, akpm@osdl.org, torvalds@osdl.org,
       sergio@sergiomb.no-ip.org, jeff@garzik.org, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, harmon@ksu.edu,
       len.brown@intel.com, vsu@altlinux.ru, liste@jordet.net
In-Reply-To: <20060910204516.GA9036@srcf.ucam.org>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <20060910002112.GA20672@kroah.com> <1157913647.5076.174.camel@mindpipe>
	 <20060910204516.GA9036@srcf.ucam.org>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 16:04:27 -0400
Message-Id: <1158696268.13845.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 21:45 +0100, Matthew Garrett wrote:
> On Sun, Sep 10, 2006 at 02:40:46PM -0400, Lee Revell wrote:
> 
> > Some applications such as realtime audio and probably gaming require
> > ACPI to be disabled, as it causes horrible latency problems.  This
> > applies equally to Linux and Windows.
> 
> How, and on what hardware?

Here's a case where the kernel does not see a user's sound card at all
unless ACPI is disabled (second to last comment):

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2174

Lee

