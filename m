Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUIXE6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUIXE6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUIXE6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:58:21 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:17031 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267772AbUIXE6U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:58:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2 ohci_hcd doesn't work
Date: Thu, 23 Sep 2004 23:58:16 -0500
User-Agent: KMail/1.6.2
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andre Eisenbach <int2str@gmail.com>,
       Roman Weissgaerber <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <dbrownell@users.sourceforge.net>
References: <200409231457.16979.bjorn.helgaas@hp.com> <7f800d9f040923142648104784@mail.gmail.com> <200409231547.21875.bjorn.helgaas@hp.com>
In-Reply-To: <200409231547.21875.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409232358.16671.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 04:47 pm, Bjorn Helgaas wrote:
> On Thursday 23 September 2004 3:26 pm, Andre Eisenbach wrote:
> > Does the DL360 have a BIOS option to allow "legacy usb devices"?
> > My notebook does, and if set to yes, it fails with that error with or
> > without pci=routeirq.
> 
> No such DL360 option that I can find.  Any idea what
> "allow legacy usb devices" means?

It is probably the same as "USB Legacy emulation" when BIOS pretends that USB
mouse and keyboard are PS/2 ones and legacy OSes (like DOS) can work without
special drivers. Avoid like plague.

-- 
Dmitry
