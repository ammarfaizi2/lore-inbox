Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVG3Oke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVG3Oke (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 10:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVG3Okd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 10:40:33 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:25768 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262974AbVG3Ok2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 10:40:28 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: iptables redirect is broken on bridged setup
Date: Sat, 30 Jul 2005 17:40:13 +0300
User-Agent: KMail/1.5.4
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org, laforge@netfilter.org, jmorris@redhat.com
References: <200507291209.37247.vda@ilport.com.ua> <20050729.123744.41648141.davem@davemloft.net>
In-Reply-To: <20050729.123744.41648141.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507301740.13239.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 July 2005 22:37, David S. Miller wrote:
> From: Denis Vlasenko <vda@ilport.com.ua>
> Date: Fri, 29 Jul 2005 12:11:52 +0300
> 
> > Linux 2.6.12
> > 
> > Was running for months with this simple iptables rule:
>  ...
> > But now I need to bridge together two eth cards in this machine, and
> > suddenly redirect is no longer works.
> 
> I think this is the regression we fixed up in 2.6.12.x, can
> you try the latest 2.6.12.x stable release and see if it
> clears up this behavioral change?

Just tested. 2.6.12.3 does not have this bug.

Thanks!
--
vda

