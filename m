Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291093AbSAaOl2>; Thu, 31 Jan 2002 09:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291092AbSAaOlT>; Thu, 31 Jan 2002 09:41:19 -0500
Received: from ns.suse.de ([213.95.15.193]:2062 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291093AbSAaOlM>;
	Thu, 31 Jan 2002 09:41:12 -0500
Date: Thu, 31 Jan 2002 15:41:12 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Mark McClelland <mark@alpha.dyndns.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <linux-usb-devel@lists.sourceforge.net>
Subject: Re: ov511 verbose startup.
In-Reply-To: <20020131053124.GI31006@kroah.com>
Message-ID: <Pine.LNX.4.33.0201311539160.7473-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Greg KH wrote:

> Yes, but odds are, it is trying to read the configuration of the device,
> and we don't have control pipe locking, yet :)
> Dave, does this problem go away on 2.5.3-pre6?

Yes. From what I recall. I'll build a pre6 later to double check.

> And which host controller driver are you using?

CONFIG_USB_UHCI_ALT=y

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

