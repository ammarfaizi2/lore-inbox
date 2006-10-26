Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422879AbWJZKT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422879AbWJZKT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423140AbWJZKT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:19:57 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:44994 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1422879AbWJZKT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:19:57 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Soeren Sonnenburg <kernel@nn7.de>, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb initialization order (usbhid vs. appletouch)
Date: Thu, 26 Oct 2006 12:20:05 +0200
User-Agent: KMail/1.8
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
In-Reply-To: <1161856438.5214.2.camel@no.intranet.wo.rk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610261220.05707.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 26. Oktober 2006 11:53 schrieb Soeren Sonnenburg:
> Dear all,
> 
> I've noticed that the appletouch driver needs to be loaded *before* the
> usbhid driver to function. This is currently impossible when built into
> the kernel (and not modules). So I wonder how one can change the
> ordering of when the usb drivers are loaded.
> 
> Suggestions ?

Add a quirk to HID. Messing around with probing orders is not
a sure thing.

	Regards
		Oliver
