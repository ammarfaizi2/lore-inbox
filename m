Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbTGTPGz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266823AbTGTPGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 11:06:55 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:33548 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S266921AbTGTPGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 11:06:39 -0400
Date: Mon, 21 Jul 2003 01:21:24 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Sean Neakums <sneakums@zork.net>
cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1-mm1] TCP connections over ipsec hang after a few
 seconds
In-Reply-To: <6u8yqt8jq3.fsf@zork.zork.net>
Message-ID: <Mutt.LNX.4.44.0307210116070.24197-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jul 2003, Sean Neakums wrote:

> I am seeing a lot of "pmtu discvovery on SA AH/03537192/c0a80003" type
> messages (I forgot to check for them when on 100baseT; will recheck
> that).  Are these indicative of such a problem?

Yes.

With the 100baseT configuration, are the systems on the same segment?

It might help to provide tcpdumps from each end, ifconfig output for each 
interface and setkey configuration (without the wlan bridging).


- James
-- 
James Morris
<jmorris@intercode.com.au>

