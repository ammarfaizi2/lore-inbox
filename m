Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265414AbTFMPbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbTFMPbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:31:24 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:27913 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S265414AbTFMPbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:31:23 -0400
Date: Sat, 14 Jun 2003 01:44:59 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Vincent Fourmond <fourmond@clipper.ens.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel comile problem
In-Reply-To: <Pine.SOL.4.44.0306131422120.22593-100000@clipper.ens.fr>
Message-ID: <Mutt.LNX.4.44.0306140143350.26147-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Vincent Fourmond wrote:

> 
> net/network.o(.text+0xd577): In function `rtnetlink_rcv':
> : undefined reference to `rtnetlink_rcv_skb'
> 
>   which I corrected by commenting out the "inline" stuff in the file
> net/core/rtnetlink.c line 397
> 
> /*extern __inline__*/ int rtnetlink_rcv_skb(struct sk_buff *skb)
> 
>   It looks like it does work, but I guess it is not normal ! Is there
> actually anything to be done about this ?

This is an old bug which is fixed in more recent 2.4 kernels.

- James
-- 
James Morris
<jmorris@intercode.com.au>

