Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290151AbSAWWNS>; Wed, 23 Jan 2002 17:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290153AbSAWWNI>; Wed, 23 Jan 2002 17:13:08 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:7431 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290151AbSAWWM4>;
	Wed, 23 Jan 2002 17:12:56 -0500
Date: Wed, 23 Jan 2002 20:12:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] rmap VM, version 12
In-Reply-To: <20020123.121857.18310310.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0201232004430.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, David S. Miller wrote:
>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Wed, 23 Jan 2002 17:36:35 -0200 (BRST)
>
>    OK, so only the _pgd_ quicklist is questionable and the
>    _pte_ quicklist is fine ?
>
> That is my understanding.

OK, then I'll disable the quick pgd list for now.
Considering the fact that the number of pgds is
small anyway it's probably not too much of a benefit
either.

The pte quicklist will stay, however. ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

