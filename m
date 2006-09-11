Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWIKOZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWIKOZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWIKOZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:25:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24437 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751225AbWIKOZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:25:40 -0400
Date: Mon, 11 Sep 2006 08:24:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: hangs during boot - EHCI: BIOS handoff failed (BIOS bug ?)
In-reply-to: <fa.Fym684Cw28LDPMZvqq5aPswjUq4@ifi.uio.no>
To: Christian Volk <christian.volk@netcom.eu>
Cc: linux-kernel@vger.kernel.org
Message-id: <450571B9.6070101@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7bit
References: <fa.Fym684Cw28LDPMZvqq5aPswjUq4@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Volk wrote:
> I have a 5-6 seconds delay while booting the 2.6.17.8 Kernel with only 
> EHCI support on a Jetway J7F2WE1G5-OC-PB motherboard.
> What exactly does the error during bootprocess mean?
> 
> Bios
> USB 2.0 Support = enabled
> USB Device Legacy Support = All On
> 
> 
> bootlog
> ...
> 0000:00:10.4 EHCI: BIOS handoff
> 0000:00:10.4 EHCI: BIOS handoff failed (BIOS bug ?) 01010001

It means that the EHCI driver was unable to take control of the USB 
controller away from the BIOS. Try upgrading the BIOS or disabling USB 
legacy in the BIOS and see if that helps.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

