Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWCUJwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWCUJwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWCUJwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:52:44 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:2177 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932380AbWCUJwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:52:44 -0500
Subject: Re: [PATCH] hci_usb: implement suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <1142934130.3964.14.camel@localhost>
References: <1137540084.4543.15.camel@localhost>
	 <1137589998.27515.8.camel@localhost>  <1137602323.4543.29.camel@localhost>
	 <1142934130.3964.14.camel@localhost>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 10:52:35 +0100
Message-Id: <1142934755.4104.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

> > The attached patch implements suspend/resume for the hci_usb bluetooth
> > driver by simply killing all outstanding urbs on suspend, and re-issuing
> > them on resume.
> > 
> > This allows me to actually use the internal bluetooth "dongle" in my
> > powerbook after suspend-to-ram without taking down all userland programs
> > (sdpd, ...) and the hci device and reloading the module.
> 
> Can someone push this patch for 2.6.17 now that 2.6.16 is out? Or is
> there still anything fundamentally wrong with it? I've been waiting for
> it forever now ;)

I will push it with some other small changes in the next few days.

Regards

Marcel


