Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVKOP3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVKOP3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVKOP3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:29:14 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:6635 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932535AbVKOP3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:29:14 -0500
Date: Tue, 15 Nov 2005 16:28:23 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Patrick Boettcher <patrick.boettcher@desy.de>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-dvb-maintainer@linuxtv.org,
       David Brigada <brigad@rpi.edu>, linux-kernel@vger.kernel.org
Message-ID: <20051115152823.GA4079@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Patrick Boettcher <patrick.boettcher@desy.de>,
	Chris Rankin <rankincj@yahoo.com>, linux-dvb-maintainer@linuxtv.org,
	David Brigada <brigad@rpi.edu>, linux-kernel@vger.kernel.org
References: <20051114235102.64514.qmail@web52912.mail.yahoo.com> <Pine.LNX.4.64.0511150939010.18517@pub3.ifh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511150939010.18517@pub3.ifh.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.250.252
Subject: Re: [linux-dvb-maintainer] Re: [OOPS] Linux 2.6.14.2 and DVB USB
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 Patrick Boettcher wrote:
> On Mon, 14 Nov 2005, Chris Rankin wrote:
> >This sounds contrary to the entire concept of hotplugging to me. And I 
> >don't think that a typical
> >desktop user would be happy to be told that s/he needs to become root and 
> >unload kernel modules
> >before s/he can unplug a USB device.
> 
> Unfortunately the dvb-core is currently not able to handle hotplugging 
> while a dvb application is accessing a dvb-dev-node. This applies 
> for every dvb-device, not only for dvb-usb devices, but no one ever tried 
> to unplug a DVB PCI card while using it, yet.
> 
> Before unplugging a device, you can check if the module is removable to 
> make sure that really no application is currently using it. (You will get 
> "module in use" then).
> 
> We already thought about that problem and we think that dvbdev.c is the 
> correct place to start implementing that, but I don't have enough 
> knowledge (and time) to do that now, sorry.

I thought someone sent a patch which fixes it for the cinergyT2
recently? Wouldn't the same approach work for dvb-usb?
(But I haven't had a chance to test the cinergyT2 patch yet.)

Johannes
