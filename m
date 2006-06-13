Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWFMWk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWFMWk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWFMWk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:40:58 -0400
Received: from palrel11.hp.com ([156.153.255.246]:21996 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S932318AbWFMWk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:40:57 -0400
Message-ID: <448F3EF5.50701@hp.com>
Date: Tue, 13 Jun 2006 15:40:53 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Cc: lkml@rtr.ca, jheffner@psc.edu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
References: <448F0D4B.30201@rtr.ca>	<20060613.142603.48825062.davem@davemloft.net>	<448F32E1.8080002@rtr.ca> <20060613.152301.26928146.davem@davemloft.net>
In-Reply-To: <20060613.152301.26928146.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One final word about window sizes.  If you have a connection whose
> bandwidth-delay-product needs an N byte buffer to fill, you actually
> have to have an "N * 2" sized buffer available in order for fast
> retransmit to work.

Is that as important in the presence of SACK?

rick jones
