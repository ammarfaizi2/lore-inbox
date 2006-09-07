Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWIGXYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWIGXYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWIGXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:24:10 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:8922 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1422722AbWIGXYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:24:08 -0400
Date: Thu, 07 Sep 2006 17:23:27 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ioread64()?
In-reply-to: <fa.zgAWvZQAAp+6nKV9Kd93QR7HZHw@ifi.uio.no>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <4500A9EF.40807@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.zgAWvZQAAp+6nKV9Kd93QR7HZHw@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Hi,
> 
> I'm looking for a way to access 64 or 128 bit of device space in a single 
> access. For smaller accesses I use ioread32() and friends. But which way 
> should I do it for the next bigger accesses? Casting the iospace to something 
> like u64* looks very suspicious to me. Any better ideas?
> 
> Greetings,
> 
> Eike

There's no portable way to do this as far as I'm aware, for the likely 
reason that on many architectures it's impossible to do it in one access..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

