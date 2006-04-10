Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWDJVKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWDJVKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWDJVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:10:39 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:30000 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751198AbWDJVKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:10:38 -0400
In-Reply-To: <200604101406.55269.david-b@pacbell.net>
References: <Pine.LNX.4.44.0604101414500.5501-100000@gate.crashing.org> <443ABA1A.1060801@gmail.com> <EB5A4A6A-BCD0-4DD0-A0F4-E155495EDCC6@kernel.crashing.org> <200604101406.55269.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2BCD876F-F27A-4405-9451-E9929650DA5D@kernel.crashing.org>
Cc: Vitaly Wool <vitalywool@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH][2.16.17-rc1-mm2] spi: Added spi master driver for Freescale MPC83xx SPI controller
Date: Mon, 10 Apr 2006 16:10:41 -0500
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 10, 2006, at 4:06 PM, David Brownell wrote:

> On Monday 10 April 2006 1:22 pm, Kumar Gala wrote:
>>
>
>> I wasn't particular happy about the spinning for ever, wasn't sure
>> what would be better.  I need to ensure we've gotten both a TX & RX
>> event before transmitting the next character.  I'm open to
>> suggestions on how to do this better.
>
> I figured that it's impossible to get an RX event without the TX
> having completed.  :)

Should I just get ride of the spin loop then?

- k
