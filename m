Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265313AbUGAN5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbUGAN5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 09:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbUGAN4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 09:56:08 -0400
Received: from web81305.mail.yahoo.com ([206.190.37.80]:36985 "HELO
	web81305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265313AbUGANy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:54:27 -0400
Message-ID: <20040701135425.12104.qmail@web81305.mail.yahoo.com>
Date: Thu, 1 Jul 2004 06:54:24 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: Continue: psmouse.c - synaptics touchpad driver sync problem
To: Marc Waeckerlin <marc.waeckerlin@siemens.com>
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Waeckerlin wrote:
> 
> Ok, here's the /var/log/messages with your patch *and* DEBUG enabled. I
> gzipped it, otherwise it's too big.
> 

I see absolutely nothing wrong in the data stream from your external
mouse, so... how is it configured in X{Free86|org}? What type is it?
Does it work in text console (with GPM)? What is your GPM setup?

Try this - in the text console do:

gpm -k
gpm -m /dev/input/mice -t ps2

Try working the mouse, is it good?

--
Dmitry   
