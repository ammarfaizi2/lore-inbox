Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264898AbUFVPZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUFVPZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUFVPQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:16:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2790 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264629AbUFVPFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:05:22 -0400
Message-ID: <40D84A9B.8010503@pobox.com>
Date: Tue, 22 Jun 2004 11:04:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, kernel@nn7.de,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       netdev@oss.sgi.com
Subject: Re: sungem - ifconfig eth0 mtu 1300 -> oops
References: <20040621141144.119be627.davem@redhat.com> <40D847E3.2080109@nortelnetworks.com>
In-Reply-To: <40D847E3.2080109@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Just a quick question.  Does the sungem chip support jumbo frames?  I'd 
> like to use MTU of 9000 to make large local transfers more efficient, 
> but it didn't seem to work last time I checked.


Are you 100% certain you configured the other side to support jumbo?

Jumbo frames are non-standard, and sometimes require configuring MTU on 
the switch or remote network card (if directly connected).

	Jeff


