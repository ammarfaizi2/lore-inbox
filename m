Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVATAOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVATAOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVATAMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:12:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24255 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261995AbVATAFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:05:53 -0500
Message-ID: <41EEF5CB.8000700@pobox.com>
Date: Wed, 19 Jan 2005 19:05:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vitezslav Samel <samel@mail.cz>
CC: Shaun Jackman <sjackman@gmail.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [NET] TUN needs CRC32 after adding multicast filtering to it
References: <20050119063257.GA10015@pc11.op.pod.cz>
In-Reply-To: <20050119063257.GA10015@pc11.op.pod.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitezslav Samel wrote:
> 	Hi!
> 
>   Just tried to compile 2.6.11-rc1, but it fails with unresolved symbols
> "bitreverse" etc. Found out that TUN driver needs CRC32 which I haven't
> compiled in.
>   Following patch fixes this. Please, consider applying.

Yes, already in -bk...

	Jeff



