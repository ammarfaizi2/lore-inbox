Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbUBDEDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUBDEDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:03:31 -0500
Received: from dp.samba.org ([66.70.73.150]:24801 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264437AbUBDEDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:03:31 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, Greg KH <greg@kroah.com>,
       jeremy@goop.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: module-init-tools/udev and module auto-loading 
In-reply-to: Your message of "Wed, 04 Feb 2004 02:04:25 -0000."
             <20040204020425.GA21151@parcelfarce.linux.theplanet.co.uk> 
Date: Wed, 04 Feb 2004 14:43:01 +1100
Message-Id: <20040204040344.CD3182C25A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040204020425.GA21151@parcelfarce.linux.theplanet.co.uk> you write:
> <shrug> If you want to mount autofs on /dev, more power to you.  However,
> it got to be explicit "I mount <this> at /dev" - _anything_ based on
> "if pathname starts with /dev, it's special" is FUBAR.

Having a process say "tell me when something non-existent under this
dir gets accessed" seems to be what is desired.  And (from my
v. limited understanding) autofs comes close already, yes?

That at least gives Martin somewhere to start...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
