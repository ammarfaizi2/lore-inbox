Return-Path: <linux-kernel-owner+w=401wt.eu-S1750721AbXAOOZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbXAOOZX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 09:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXAOOZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 09:25:23 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:10160 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXAOOZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 09:25:23 -0500
Date: Mon, 15 Jan 2007 08:24:31 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: prioritize PCI traffic ?
In-reply-to: <fa.IZ3qyPHQu5qQWnA4jBWoHC54zJE@ifi.uio.no>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <45AB8E9F.9020901@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.IZ3qyPHQu5qQWnA4jBWoHC54zJE@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:
> Dear all,
> 
> is it possible to explicitly tell the kernel to prioritize PCI traffic
> for a number of cards in pci slots x,y,z ?
> 
> I am asking as severe ide traffic causes lost frames when watching TV
> using 2 DVB cards + vdr... This is simply due to the fact that the PCI
> bus is saturated...
> 
> So, is any prioritizing of the PCI bus possible ?

That would be chipset dependent. Some chipsets may be able to assign 
different arbitration priorities to different slots, but certainly you 
can't do this generically..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

