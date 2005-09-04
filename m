Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVIDQ4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVIDQ4P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 12:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVIDQ4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 12:56:15 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:37767 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750968AbVIDQ4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 12:56:14 -0400
Message-ID: <431B2717.6020706@gmail.com>
Date: Sun, 04 Sep 2005 18:55:51 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
CC: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: [ATMSAR] Request for review - update #1
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni napsal(a):

>I attach a fixed version of the atmsar patch as a diff against the 2.6.13 kernel tree.
>  
>
static inline void dump_skb (char * prefix, unsigned int vc, struct 
sk_buff * skb) {
what's this? 81+ chars on line
{ on a newline, please
' * ' --> ' *'

  spin_lock_irqsave (&txq->lock, flags);
indent is tab (tab is as long as 8 chars), no 3, 4, 5 or ... spaces

and many, many others, please read CodingStyle in Documentation.

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

