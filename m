Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937025AbWLDPfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937025AbWLDPfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937027AbWLDPfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:35:20 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:53279 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937025AbWLDPfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:35:18 -0500
Message-ID: <45744051.5070901@cfl.rr.com>
Date: Mon, 04 Dec 2006 10:35:45 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: alan@lxorguk.ukuu.org.uk, matthew.garman@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: What happened to CONFIG_TCP_NAGLE_OFF?
References: <E1GqLZ0-0006iY-00@gondolin.me.apana.org.au>
In-Reply-To: <E1GqLZ0-0006iY-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2006 15:35:22.0487 (UTC) FILETIME=[CFBAE870:01C717B9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14852.003
X-TM-AS-Result: No--10.897000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Congestion control is always appropriate in a shared network.  Please
> note that congestion control does not conflict with the objectives of
> UDP.  For UDP, congestion control can simply mean dropping packets at
> the source.  DCCP is a good replacement for UDP that has congestion
> control.

That is why I said that the application should implement its own 
congestion control, just in a different way than TCP does that is more 
appropriate to the specific needs of the application.


