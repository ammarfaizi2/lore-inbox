Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWKUVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWKUVJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWKUVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:09:47 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46302 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161254AbWKUVJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:09:46 -0500
Message-ID: <45636B13.9090909@garzik.org>
Date: Tue, 21 Nov 2006 16:09:39 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, htejun@gmail.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sata_promise updates
References: <200611212057.kALKvL8n009798@harpo.it.uu.se> <45636A85.40700@garzik.org>
In-Reply-To: <45636A85.40700@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 1) no_tbg_slew_init should be a bit flag ("1 << 0") inside a 'flags' 
> variable in struct pdc_host_priv.


Thinking some more, a 'is_gen_II' bit flag inside a 'flags' struct 
member would more accurately describe what the boolean flag indicates.

Once NCQ support is added, we will probably have to test this flag in 
code unrelated to TBG/slew registers.

	Jeff


