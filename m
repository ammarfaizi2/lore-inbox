Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWJFPKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWJFPKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 11:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWJFPKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 11:10:17 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:14046 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751291AbWJFPKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 11:10:16 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [PATCH 1/3] UEAGLE : be suspend friendly
Date: Fri, 6 Oct 2006 17:10:09 +0200
User-Agent: KMail/1.9.4
Cc: Pavel Machek <pavel@ucw.cz>, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, ueagle <ueagleatm-dev@gna.org>,
       matthieu castet <castet.matthieu@free.fr>
References: <Pine.LNX.4.44L0.0610051621410.7144-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610051621410.7144-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061710.10603.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe UEAGLE can do something a little more sensible...

What is the modem supposed to do if it receives a packet to
transmit after it has been told to suspend?  This is a real
question, I'm not pretending!  I've never thought about or
read about suspend/resume and have no idea how it is supposed
to work.  Should it just reject it, or should it wake the
modem up?

Ciao,

Duncan.
