Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310145AbSCKO7w>; Mon, 11 Mar 2002 09:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310142AbSCKO7f>; Mon, 11 Mar 2002 09:59:35 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:38413 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S310141AbSCKO7N>; Mon, 11 Mar 2002 09:59:13 -0500
Message-Id: <200203111456.g2BEunq05675@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] KERN_INFO 2.4.19-pre2 IP/TCP hash table size printks
Date: Mon, 11 Mar 2002 16:56:02 -0200
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <200203111359.g2BDx1q05409@Port.imtp.ilyichevsk.odessa.ua> <20020311.060324.69703263.davem@redhat.com>
In-Reply-To: <20020311.060324.69703263.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 March 2002 12:03, David S. Miller wrote:
>    From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
>    Date: Mon, 11 Mar 2002 15:58:15 -0200
>
>    Primary purpose of this patch is to make KERN_WARNING and
>    KERN_INFO log levels closer to their original meaning.
>    Today they are quite far from what was intended.
>    Just look what kernel writes at the WARNING level
>    each time you boot your box!
>
> Maybe it is even better idea to change default kernel printk
> logging level which is used when no KERN_* is specified, eh?

Not "eh", "yeah!" instead :-) I like this idea.
But how to convince everybody else?
--
vda
