Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUGWMq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUGWMq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 08:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267691AbUGWMq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 08:46:59 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:55527 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S267690AbUGWMq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 08:46:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: changing ethernet devices, new one stops cold at iptables
Date: Fri, 23 Jul 2004 08:46:56 -0400
User-Agent: KMail/1.6
References: <200407222114.20301.gene.heskett@verizon.net> <4100F2F0.3080300@redhat.com>
In-Reply-To: <4100F2F0.3080300@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407230846.56144.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [141.153.92.37] at Fri, 23 Jul 2004 07:46:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 July 2004 07:13, Neil Horman wrote:
>>Gene Heskett wrote:

>> One thing I haven't tried is to reset the MAC address for the
>> nforce2 ethernet to match the D-Links hardware address.  Is it
>> worth a try just to prove the point?
>
>I'd think so.  Its a two minute test to verify that the problem is
>related to the MAC address of nic in the firewall.  You may also
> want to add a LOG target to all the chains in your firewall to
> match on the origional MAC address so you can see what your
> iptables code is doing with the packet.
>
>HTH
>Neil

I'm in the process of trying that Neil, but if thats the case, it 
means I cannot ever re-use that nic in another machine here.  What 
I'd druther do if this test proves positive, is to figure out howto 
get the arp tables updated on the firewall so they reflect the new 
MAC address for this machine.  I've got both drivers as modules 
effective with the next reboot so the testing switching will be much 
easier.

Thanks for the shoulder to cry on.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
