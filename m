Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUBGDEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUBGDEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:04:47 -0500
Received: from bay1-f23.bay1.hotmail.com ([65.54.245.23]:57095 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266546AbUBGDEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:04:41 -0500
X-Originating-IP: [65.25.165.241]
X-Originating-Email: [jw2357@hotmail.com]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] killing the AMD53C974 and mac_NCR5380 drivers
Date: Sat, 07 Feb 2004 03:04:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F23xAHXBejKV010001f615@hotmail.com>
X-OriginalArrivalTime: 07 Feb 2004 03:04:40.0046 (UTC) FILETIME=[207398E0:01C3ED27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the AM53C974 driver sounds like a good idea, but be aware that the 
tmscsim driver included on the RedHat driver disks (for people who have to 
boot by floppy) causes a panic on boot ever since 7.3 on XU 5/90 machines. 
The AM53C974 driver is very minimalistic, but seems to work. Once the system 
is installed, the AM53C974 driver isn't stable long-term and I have to use 
tmscsim.

So before deleting the driver, keep in mind that without it, there would be 
no way to install RedHat's distros on the older Vectra's. Of course the 
tmscsim driver included on the RedHat driver disk could be broken...

- John

_________________________________________________________________
Choose now from 4 levels of MSN Hotmail Extra Storage - no more account 
overload! http://click.atdmt.com/AVE/go/onm00200362ave/direct/01/

