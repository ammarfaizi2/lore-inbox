Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWJ1Sae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWJ1Sae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWJ1Sae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:30:34 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:23215 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1751325AbWJ1Sad convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:30:33 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] usb initialization order (usbhid vs. appletouch)
Date: Sat, 28 Oct 2006 20:30:46 +0200
User-Agent: KMail/1.8
Cc: Pete Zaitcev <zaitcev@redhat.com>, Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1161856438.5214.2.camel@no.intranet.wo.rk> <1162054576.3769.15.camel@localhost> <20061028111454.787894e8.zaitcev@redhat.com>
In-Reply-To: <20061028111454.787894e8.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610282030.47076.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 28. Oktober 2006 20:14 schrieb Pete Zaitcev:
> > OK, so I tried adding all of them to the HID_QUIRK_IGNORE LIST, i.e.
> 
> This, of course, cannot possibly work, as we discussed a month ago.
>  http://lkml.org/lkml/2006/10/1/18
> 
> So, you two are just beating a dead horse. It's time to write the code
> which identifies Apple devices and not try to ride a quirk.

No, this will need a quirk, just one that is more specific. Globally
triggering on Apple won't do.

	Regards
		Oliver
