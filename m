Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUIBMUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUIBMUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUIBMUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:20:51 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:32960 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S268279AbUIBMUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:20:48 -0400
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Date: Thu, 2 Sep 2004 14:20:46 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409021401.42255.elueck@de.ibm.com> <1094123102.4996.10.camel@localhost.localdomain>
In-Reply-To: <1094123102.4996.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021420.46785.elueck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 2. September 2004 13:05 Alan Cox wrote:
> On Iau, 2004-09-02 at 13:01, Einar Lueck wrote:
> > The high-availability requirements drive those customers to ensure that 
> > all routes are dynamic which is not possible with the proposed ip route 
> > approach.
> 
> Why. You are simply doing NAT for that port from all locally sourced
> packets to your "virtual" address ? 
I thought You proposed to utilize ip route in the following way:
"ip route xxx.xxx.xxx.xxx/xx via xxx dev xxx src MY_VIRTUAL_IP_ADDRESS"
This approach does not work with the setups we have in mind. So I misunderstood 
You. As we pointed out in the other part of the mail iptables NAT is not an option 
for the relevant customers.

Einar
