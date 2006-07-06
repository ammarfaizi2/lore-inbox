Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWGFO2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWGFO2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWGFO2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:28:11 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3970 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030290AbWGFO2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:28:10 -0400
Date: Thu, 06 Jul 2006 08:26:09 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: How to reset pci device
In-reply-to: <1152172405.112420.80940@m73g2000cwd.googlegroups.com>
To: earthquake.de@freenet.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44AD1D81.9000907@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1152172405.112420.80940@m73g2000cwd.googlegroups.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

earthquake.de@freenet.de wrote:
> Hi,
> i have the following problem:
> A Pci-device is not set up correctly, (this is caused by the producer
> of the pci device
> and can not be changed).
> But for test purposes i read the confi space from the pci device( just
> the BARs)
> reset the pci device manually.
> After this reset i write the read confi space back (just the BARs and
> command register).

If you mean issuing a reset to that specific device, there is no 
portable way to do this, if there is any way at all. In most cases it's 
likely impossible to reset just one device on the PCI bus.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

