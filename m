Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWFAXg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWFAXg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWFAXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:36:28 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4814 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750952AbWFAXg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:36:27 -0400
Date: Thu, 01 Jun 2006 17:35:22 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
In-reply-to: <6iX82-2UJ-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <447F79BA.4090904@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6iWP5-2gj-71@gated-at.bofh.it> <6iX82-2UJ-3@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Many, most, perhaps all such devices don't take more power when they
> are "enabled". Everything is already running and sucking up maximum
> current when you plug it in! If the motherboard didn't smoke when
> the device was plugged in, you might just as well let the user use
> it! Perhaps a ** WARNING ** message somewhere, but by golly, they
> got it running or else you wouldn't be able to read its parameters.

Wrong.. USB devices are not allowed to draw more than some amount (100 
mA I think) of power before the host tells it that it is allowed to 
switch into full-power mode. Any device that doesn't do this doesn't 
comply with the USB specs. Therefore it is very possible to connect a 
device and discover that it can't be enabled.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

