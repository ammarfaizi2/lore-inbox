Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTKPKVI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 05:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTKPKVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 05:21:08 -0500
Received: from evrtwa1-ar2-4-35-049-074.evrtwa1.dsl-verizon.net ([4.35.49.74]:35753
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S262679AbTKPKVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 05:21:06 -0500
Message-ID: <3FB74F87.1090100@candelatech.com>
Date: Sun, 16 Nov 2003 02:20:55 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: azarah@nosferatu.za.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: Carrier detection for network interfaces
References: <1068912989.5033.32.camel@nosferatu.lan> <3FB652BA.1010905@pobox.com>
In-Reply-To: <3FB652BA.1010905@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Martin Schlemmer wrote:
> 
>> Is there any proper way to detect a carrier signal with network
>> interfaces ?  I have recently come across a problem where we tried
>> to do with with checking for 'RUNNING', which do not work for all
>> drivers, as well as mii-tool that fails in some cases.
> 
> 
> 
> What kernel version?
> 
> In 2.6 you have linkwatch.  In 2.4 and 2.6, you have ETHTOOL_GLINK, and 
> mii-tool.

One thing to watch for, lots of drivers will not detect link
if the interface itself is not configured to be running (UP).
You can configure it up without an IP address of course...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


