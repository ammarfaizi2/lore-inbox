Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVCABWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVCABWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCABWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:22:12 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:20333 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261202AbVCABVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:21:18 -0500
Date: Mon, 28 Feb 2005 19:21:14 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Complicated networking problem
In-reply-to: <3CLkr-2LJ-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4223C38A.2040206@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3CLkr-2LJ-7@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarne Cook wrote:
> Is there a way to allow an application which has bound to wlan0 
> (192.168.0.202) and an application bound to eth0 (192.168.0.238) both have 
> access to the internet at the same time, and not require an application to 
> bind to a different local address?

I'm not sure exactly what you want to have happen here.. if an 
application is making outbound connections it has to effectively use one 
interface or the other. If you want to switch between the two of them 
automatically, something like 
NetworkManager(http://people.redhat.com/dcbw/NetworkManager/) may work, 
however it's not going to be seamless (as in, preserving open 
connections), since the IP addresses are different..

-- 
Robert Hancock      Saskatoon, SK, Canada
Home Page: http://www.roberthancock.com/


