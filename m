Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbWCIEDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbWCIEDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWCIEDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:03:42 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:38045 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932669AbWCIEDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:03:41 -0500
Date: Wed, 08 Mar 2006 22:03:34 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Kernel panic on PC with broken hard drive, after DMA errors
In-reply-to: <5Okau-77g-9@gated-at.bofh.it>
To: Martin Michlmayr <tbm@cyrius.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440FA916.5070703@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Okau-77g-9@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr wrote:
> My laptop hard drive recently died (or is in the process of dying).
> HP wanted me to do some more tests before sending me a replacement, so
> I tried booting Linux again today.  I got lots of DMA errors, which
> was really to be expected, but then I got a kernel panic.  While I'd
> not blame the kernel when a panic occurs with broken RAM or CPU, I'm
> sure sure the kernel should panic just because of a broken IDE drive.
> 
> I posted a picture of the panic at http://cyrius.com/tmp/ide_panic.jpg
> Is this something that can be fixed or is my hardware really so broken
> that the kernel cannot deal with it?

Probably is a genuine bug. These kinds of reports have come up a few 
times recently as I recall - it seems some of the error handling in the 
drivers/ide code isn't quite so robust..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

