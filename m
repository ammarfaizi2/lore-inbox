Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUDMNqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 09:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbUDMNqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 09:46:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19126 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263480AbUDMNqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 09:46:33 -0400
Date: Tue, 13 Apr 2004 09:46:11 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: "David S. Miller" <davem@redhat.com>, <netdev@oss.sgi.com>,
       =?iso-2022-jp?Q?YOSHIFUJI_Hideaki_=2F_=1B$B5HF#1QL=40=1B=28B?= 
	<yoshfuji@linux-ipv6.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <200404121623.42558.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Xine.LNX.4.44.0404130945460.14102-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Denis Vlasenko wrote:

> According to my measurements,
> 
> ip_vs_control_add() (from include/net/ip_vs.h) is called twice
> and
> sock_queue_rcv_skb() (from include/net/sock.h) is called 19 times
> from various kernel .c files.
> 
> Both these includes generate more than 500 bytes of code on x86.
> 
> These patches uninline them. Please apply.

What kind of performance impact (if any) does this patch have?


- James
-- 
James Morris
<jmorris@redhat.com>


