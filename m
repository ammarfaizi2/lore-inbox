Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTDRSEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTDRSEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:04:15 -0400
Received: from palrel11.hp.com ([156.153.255.246]:61412 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263185AbTDRSEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:04:14 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16032.16617.632481.857276@napali.hpl.hp.com>
Date: Fri, 18 Apr 2003 11:16:09 -0700
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB deadlock in v2.5.67
In-Reply-To: <3EA01DF0.9080305@pacbell.net>
References: <200304180202.h3I227mw032608@napali.hpl.hp.com>
	<20030418045006.GB1813@kroah.com>
	<3EA01DF0.9080305@pacbell.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 18 Apr 2003 08:46:56 -0700, David Brownell <david-b@pacbell.net> said:

  David> Seems to be a different problem.  The patch below should
  David> resolve the keyboard problem -- just reorders two lines so
  David> the lock isn't held after the device's records get deleted,
  David> so the order is what it should always have been.

With the patch applied, I can now add/remove USB keyboards without
crashing the kernel.

Thanks!

	--david

