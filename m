Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265123AbSKNRxu>; Thu, 14 Nov 2002 12:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSKNRxu>; Thu, 14 Nov 2002 12:53:50 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:33031 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265058AbSKNRxt>; Thu, 14 Nov 2002 12:53:49 -0500
Date: Thu, 14 Nov 2002 16:00:22 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Serge Kuznetsov <sk@deeptown.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [NET] Possible bug in netif_receive_skb
Message-ID: <20021114180022.GF14579@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Serge Kuznetsov <sk@deeptown.org>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
References: <015301c28c00$f6287390$34c096cd@toybox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015301c28c00$f6287390$34c096cd@toybox>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 14, 2002 at 12:12:07PM -0500, Serge Kuznetsov escreveu:

> PS: BTW, how to check if skb has been freed ? I didn't found any function for
> it. Is it possible to add the flag, like skb->freed ?

Enable slab poisoning.

- Arnaldo
