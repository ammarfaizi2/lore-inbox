Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWFVO1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWFVO1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWFVO0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:26:53 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24875 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030294AbWFVO0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:26:35 -0400
Date: Thu, 22 Jun 2006 08:24:29 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
In-reply-to: <fa.xi8WlIQLoSpgs6byyFeCFmlTjCE@ifi.uio.no>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Antonio Vargas <windenntw@gmail.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org
Message-id: <449AA81D.8090007@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.RonUKQ4bRxV1BEEAvvcvwPKcfXM@ifi.uio.no>
 <fa.xi8WlIQLoSpgs6byyFeCFmlTjCE@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
>> This would have
>> different timings on different cpu kinds...
> 
> Yes. This is just a debugging patch to help me pinpoint where
> the problem is.
> 
>> maybe a short usleep()?
> 
> It can be called in any context, so sleep() will be illegal
> in certain circumstances.

That's what udelay is for :-)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

