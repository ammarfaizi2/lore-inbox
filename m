Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUIWV3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUIWV3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUIWV2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:28:45 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:58509 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267397AbUIWV07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:26:59 -0400
Message-ID: <7f800d9f040923142648104784@mail.gmail.com>
Date: Thu, 23 Sep 2004 14:26:48 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.9-rc2-mm2 ohci_hcd doesn't work
Cc: Roman Weissgaerber <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <dbrownell@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200409231457.16979.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409231457.16979.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 14:57:16 -0600, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>  ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
>  ohci_hcd 0000:00:0f.2: init err (00002edf 0000)
>  ohci_hcd 0000:00:0f.2: can't start
>  ohci_hcd 0000:00:0f.2: init error -75
>  ohci_hcd 0000:00:0f.2: remove, state 0
>  ohci_hcd 0000:00:0f.2: USB bus 1 deregistered
>  ohci_hcd: probe of 0000:00:0f.2 failed with error -75

Bjorn,

I just sent you email (because dmesg told me too :D ) with exactly the
same error message. However, for me it only occurs without
"pci=routeirq".

Does the DL360 have a BIOS option to allow "legacy usb devices"?
My notebook does, and if set to yes, it fails with that error with or
without pci=routeirq.

Cheers,
    Andre
