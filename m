Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbULRGBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbULRGBj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 01:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbULRGBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 01:01:38 -0500
Received: from web51503.mail.yahoo.com ([206.190.38.195]:55386 "HELO
	web51503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262842AbULRGBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 01:01:35 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=yDXIpfgc+KL6+1wZMOzNy/HGus+mTlEVSytKDeSPG9BJG3q2ZIAXoudosmiHt18AXc23rE2liABWZQokAKSDzYUTMrz70fBZcBwRIygTxHftRsjMu8OiLuX4farbKty83mgTB0qprDg8NiFgjBNFP0sAtxdgmA8LQbBTb9ZMBdM=  ;
Message-ID: <20041218060134.77655.qmail@web51503.mail.yahoo.com>
Date: Fri, 17 Dec 2004 22:01:34 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Issue on netconsole vs. Linux kernel oops
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, ipsec-tools-devel@lists.sourceforge.net
In-Reply-To: <20041217164419.GO2767@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004 at 08:44, Matt Mackall wrote:
>
> Netconsole builds very simple IPv4 packets by hand 
> without the use of the rest of the IP stack. This 
> is how it continues to work when the system is 
> crashing. So it will never be able to build IPSEC 
> packets.
> Nor is it likely to do IPv6 any time soon.
>
> You can probably get it to work by using a 
> different IP address for netconsole than you use 
> for IPSEC, and set up the receiving end to
> recognize packets from that address as normal 
> unencrypted IPv4.

Thank you.

But that will need at least 3 computers(i.e. 2 for
IPsec, 1 for receiving end), Am I right?


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
