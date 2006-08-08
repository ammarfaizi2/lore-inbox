Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWHHOYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWHHOYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWHHOYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:24:06 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49459 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964907AbWHHOYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:24:05 -0400
Date: Tue, 08 Aug 2006 08:22:49 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
In-reply-to: <fa.FhtZk3YiH9OyGCt4iXIGt+vYtos@ifi.uio.no>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <44D89E39.1000908@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.FhtZk3YiH9OyGCt4iXIGt+vYtos@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Stewart wrote:
> Hi,
> I have a Dell Optiplex GX280, a Pentium 4 with an Intel chipset. It has
> 4G of ram. The problem is I can only see 3.2G, even tho the bios reports
> 4G.

There was a thread on this subject a little while ago. Essentially it is 
a chipset limitation (i.e. lack of support for memory hole remapping, 
memory hoisting, whatever you want to call it) and there's nothing that 
can really be done about it. Even a 64-bit kernel will have the same 
problem.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

