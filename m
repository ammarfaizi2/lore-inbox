Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277547AbRJOPLC>; Mon, 15 Oct 2001 11:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277546AbRJOPKw>; Mon, 15 Oct 2001 11:10:52 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:32786 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S277545AbRJOPKg>; Mon, 15 Oct 2001 11:10:36 -0400
Date: Tue, 16 Oct 2001 01:10:45 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Shiva Raman Pandey <shiva@sasken.com>
cc: <linux-kernel@vger.kernel.org>, <netfilter@lists.samba.org>
Subject: Re: Netfilter  and Dynamics Mobile IP
In-Reply-To: <9qeqf7$brv$1@ncc-z.sasken.com>
Message-ID: <Pine.LNX.4.31.0110160107320.28792-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Shiva Raman Pandey wrote:

> Now I am trying to grab all mobile IP control messages and packets using
> Netfilter.
> Commands I used are : (on the PC running as Home Agent)
> iptables -A OUTPUT -p icmp -j QUEUE
> dynhad --fg --debug
>

Why are you using the QUEUE target?

I'm not familiar with the Mobile IP package you're using, although a quick
check of the source of that version doesn't reveal an obvious connection.

Please followup to the netfilter mailing list.

- James
-- 
James Morris
<jmorris@intercode.com.au>


