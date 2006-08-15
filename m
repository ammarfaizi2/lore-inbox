Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWHOOau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWHOOau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWHOOat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:30:49 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:59566 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030308AbWHOOas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:30:48 -0400
Date: Tue, 15 Aug 2006 08:29:43 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: What determines which interrupts are shared under Linux?
In-reply-to: <fa.xiop2gho7OdOydmzXzpUsR5ksXM@ifi.uio.no>
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Message-id: <44E1DA57.4010309@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.xiop2gho7OdOydmzXzpUsR5ksXM@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Heflin wrote:
> Hello,
> 
> On Linux when interrupts are defined similar to below, what defines say
> ide2, ide3 to be on the same interrupt?    The bios, linux, the driver 
> using
> the interrupt?    And can that be controlled/overrode at the 
> kernel/driver level?
> 

Typically this is determined by the hardware routing of the interrupt 
lines on the motherboard, occasionally the BIOS. There isn't usually 
much that can be done about the sharing at the kernel level.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

