Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbTDPQba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTDPQb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:31:29 -0400
Received: from [203.117.131.12] ([203.117.131.12]:8128 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S264468AbTDPQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:31:25 -0400
Message-ID: <3E9D8823.5060105@metaparadigm.com>
Date: Thu, 17 Apr 2003 00:43:15 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: James Bourne <jbourne@hardrock.org>
Cc: Lincoln Dale <ltd@cisco.com>, Jurjen Oskam <jurjen@quadpro.stupendous.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Booting from Qlogic qla2300 fibre channel card
References: <Pine.LNX.4.44.0304160952470.1406-100000@cafe.hardrock.org>
In-Reply-To: <Pine.LNX.4.44.0304160952470.1406-100000@cafe.hardrock.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually i just realized after checking - we are using 6.04 also (standard
- not failover). The error and abort messages in my previous were from
the 6.04 driver.

Happens on 2 different machines that do around 200 IOs/sec during the day.

We are beginning to suspect heat from a e1000 in a slot next door.
All the crashes occur when our thermostat switches to one aircon instead
of two although the ambient temp is around 25 celcius which is still
relatively cool. Sometimes after the failure, the card will fail to
re-initialise after a cold boot but works after leaving the machine
off for about 20 minutes.

~mc

On 04/16/03 23:56, James Bourne wrote:
> On Wed, 16 Apr 2003, Michael Clark wrote:
> 
> 
>>Hi,
> 
> ...
> 
>>I'm currently looking for alternatives to qlogic HBAs after a year of
>>not being able to find a stable driver combo (one that can stand up
>>for more than a few weeks). Does any one out there have experience
>>with the LSI HBAs and Fusion MPT drivers or perhaps Emulex?
> 
> 
> We are currently using the EMC approved 6.04-fo qla2300 driver with great
> success.  With multiple connections to a CX600 fail over occurs properly, it
> also does failover for the tape drives, and the system has been running for
> about 40 days without any problems...
> 
> YMMV, but for us it has been working quite well.
> 
> Regards
> James Bourne
> 

