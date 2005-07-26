Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVGZUFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVGZUFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVGZUFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:05:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57247 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262017AbVGZUDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:03:53 -0400
Message-ID: <42E69661.10700@redhat.com>
Date: Tue, 26 Jul 2005 16:00:33 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH NFS 3/3] Replace nfs_block_bits() with	roundup_pow_of_two()
References: <20050724143640.GA19941@lsrfire.ath.cx>	 <1122246549.8322.3.camel@lade.trondhjem.org>	 <1122247463.8322.19.camel@lade.trondhjem.org>	 <20050725155611.GA12856@lsrfire.ath.cx> <1122400127.6894.32.camel@lade.trondhjem.org>
In-Reply-To: <1122400127.6894.32.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>må den 25.07.2005 Klokka 17:56 (+0200) skreiv Rene Scharfe:
>
>  
>
>>What's your opinion of the following patch, which explicitly states the
>>intent of nfs_block_bits()?  It still needs patch 1 and 2.
>>    
>>
>
>I really don't like the choice of name. If you feel you must change the
>name, then make it something like nfs_blocksize_align(). That describes
>its function, instead of the implementation details.
>

I would agree.  Was there really a driving requirement to change the name?

    Thanx...

       ps
