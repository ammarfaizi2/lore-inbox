Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161435AbWJ0EEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbWJ0EEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 00:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161487AbWJ0EEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 00:04:06 -0400
Received: from [84.77.121.105] ([84.77.121.105]:10671 "EHLO
	merak.nimastelecom.com") by vger.kernel.org with ESMTP
	id S1161435AbWJ0EED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 00:04:03 -0400
Message-ID: <4541852A.7020701@newipnet.com>
Date: Fri, 27 Oct 2006 06:03:54 +0200
From: Carlos Velasco <lkml@newipnet.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Networking messed up, bad checksum, incorrect length
References: <E1GdItF-0002uT-00@gondolin.me.apana.org.au>
In-Reply-To: <E1GdItF-0002uT-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu escribió:

> netfilter will see the jumbo frames rather than the individual packets.

I wonder if this could affect the TCP stateful tracking of netfilter
making the ACK drops I see.

Regards,
Carlos Velasco
CCNP & CCDP Cisco Certified Network Professional

