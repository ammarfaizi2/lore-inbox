Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135855AbRA1PVK>; Sun, 28 Jan 2001 10:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135420AbRA1PVA>; Sun, 28 Jan 2001 10:21:00 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:52608 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135905AbRA1PUt>; Sun, 28 Jan 2001 10:20:49 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010127151141.E8236@conectiva.com.br> 
In-Reply-To: <20010127151141.E8236@conectiva.com.br> 
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Jan 2001 15:20:18 +0000
Message-ID: <20511.980695218@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


acme@conectiva.com.br said:
>  Please send additions and corrections to me and I'll try to keep it
> updated.

Anything which uses sleep_on() has a 90% chance of being broken. Fix
them all, because we want to remove sleep_on() and friends in 2.5.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
