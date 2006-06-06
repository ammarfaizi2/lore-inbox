Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWFFIrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWFFIrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWFFIrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:47:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:4207 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751129AbWFFIrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:47:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oagYAhsvW8DXPFWnlGYO8x6VKLRk6wtdAOeY12EshTY97FTOrrhEmuVlLFOnLsG1JaVR7S93WncFxcwMN6uYRs3xUQbsdVvafsxsNat6kUy4E590wEYrh1lDglt73LY1kIELwJS4xNzYBCUmyViGQaD3+jVFUKSZ+H4BTy6QPuY=
Message-ID: <b0943d9e0606060147h5f7e3520pfe652c7cc2818df3@mail.gmail.com>
Date: Tue, 6 Jun 2006 09:47:39 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.17-rc5 0/8] Kernel memory leak detector 0.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0606051452p26f20c8r57f2c782de691210@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
	 <6bffcb0e0606051452p26f20c8r57f2c782de691210@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> System hangs while starting udev.
>
> Here is config
> http://www.stardust.webpages.pl/files/kml/kml-config
>
> Here is "Kernel Bug : The Movie 2" ;)
> http://www.stardust.webpages.pl/files/crap/kbtm2.avi

I mananged to play it but there isn't anything obvious. Are there any
messages from kmemleak (it's pretty hard to read the screen in this
movie)?

Could you try with SMP disabled? The locking mechanism in kmemleak
should be OK but I might have missed something.

-- 
Catalin
