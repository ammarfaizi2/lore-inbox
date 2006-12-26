Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbWLZC5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWLZC5X (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 21:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWLZC5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 21:57:23 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2601 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbWLZC5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 21:57:22 -0500
Date: Mon, 25 Dec 2006 20:57:11 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Kernel 2.6.17.13: eth2: TX underrun, threshold adjusted.
In-reply-to: <fa.8x7CSG3Vz8/rASmsmG0lScp7gAc@ifi.uio.no>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <45908F87.9010205@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.8x7CSG3Vz8/rASmsmG0lScp7gAc@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> I am using a dual port Intel NIC on an A-Bit IC7-G; any reason why I get 
> these?
> 
> [4298634.444000] eth2: TX underrun, threshold adjusted.
> [4299146.645000] eth2: TX underrun, threshold adjusted.

...

> I am using the e100 driver, MAC addr commented out with **.
> 
> [4294675.208000] eth2: 0000:04:04.0, 00:**:**:**:**:**, IRQ 18.
> [4294675.209000]   Receiver lock-up bug exists -- enabling work-around.
> [4294675.209000]   Board assembly 711269-003, Physical connectors present: 
> RJ45

I don't think you are using e100, these messages seem to be from 
eepro100, not e100. Try disabling eepro100 and see if e100 works.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

