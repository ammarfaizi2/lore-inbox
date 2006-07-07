Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWGGMX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWGGMX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGGMX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:23:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:28822 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932086AbWGGMXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:23:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hqzhyRf2wGPNp+8eEdbrCvwf6aI7RyEJzOLVAJf12rEnH4l8sUV8x+1uPsu0RUKRmYe7R/m0Vq4mrdqyosd4QlLfczBenwhxMNgSkowaO4jj8wy8jCVPvA95F5llQAxuGpydDEWsWMw+fLu4Ino8d75x369ht/WoX/2mqrSB7lc=
Message-ID: <84144f020607070523t62de1abar959744be35a6ca63@mail.gmail.com>
Date: Fri, 7 Jul 2006 15:23:54 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
In-Reply-To: <20060707115422.GA4705@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060513033742.GA18598@hellewell.homeip.net>
	 <20060520095740.GA12237@infradead.org>
	 <20060707115422.GA4705@infradead.org>
X-Google-Sender-Auth: 285fbf1aebef2126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/06, Christoph Hellwig <hch@infradead.org> wrote:
>  - any reason to use the SLAB_* flags instead of GFP_?  I'm a bit surprised
>    SLAB_* still exists at all..

I have been wanting to kill the SLAB_* flags for some time now, so
yes, please use the GFP_* ones instead. Thanks.

                                               Pekka
