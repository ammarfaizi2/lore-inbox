Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760653AbWLFOhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760653AbWLFOhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760664AbWLFOhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:37:45 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:32790 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760660AbWLFOho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:37:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UxC0OMo1LmkMVyjAu9NLhsyTg8TGYtvHZTlh3nfqAzOwddtS4eLGWRDx+MfgXzPkBFJEAUo6ksjt1fcCzM5BUcbTyP8LR0qdyrtLGCr2RF2li4hSoLkkpqtob18fV99TF0SyMyfG3i3ujw20sWMrNTO2R4Hjv7pQAFZB767z10k=
Message-ID: <3bd6b93c0612060637g2c6f4b5bld4006b40244a7b06@mail.gmail.com>
Date: Wed, 6 Dec 2006 09:37:43 -0500
From: "Bruce Ashfield" <bruce.ashfield@windriver.com>
To: "Paul Sokolovsky" <pmiscml@gmail.com>
Subject: Re: Re[2]: More ARM binutils fuckage
Cc: "Lennert Buytenhek" <buytenh@wantstofly.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       "Linux Kernel List" <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>,
       linux-arm-toolchain@lists.arm.linux.org.uk,
       linux-arm-kernel@lists.arm.linux.org.uk, crossgcc@sourceware.org
In-Reply-To: <582252003.20061206084328@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061205193357.GF24038@flint.arm.linux.org.uk>
	 <f2b55d220612051529t3c0dcda8ma920c13b00899b10@mail.gmail.com>
	 <20061206002226.GK24038@flint.arm.linux.org.uk>
	 <20061206010813.GC30401@xi.wantstofly.org>
	 <582252003.20061206084328@gmail.com>
X-Google-Sender-Auth: b5fad7dc52520060
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Paul Sokolovsky <pmiscml@gmail.com> wrote:
> Hello Lennert,
>
> Wednesday, December 6, 2006, 3:08:13 AM, you wrote:
>
> []
> > (These
> > days I build all kernels in EABI mode with old-ABI compat.)  I have
> > not run into any code generation issues with this compiler yet.
>
>   I wonder, if OABI-compat is known to actually work on OABI userspace,
> I mean, on something real, like xserver-kdrive ;-). Because I'd really
> like to build single kernel for both old and new userspace too, but
> afraid to try that, fearing to be put down by another broken feature
> ;-).

I've used OABI-compat + EABI ARM kernels to routinely switch between
OABI and EABI rootfs boots. There were some minor busybox issues
on the OABI-compat side (w.r.t. syscalls), but nothing major. These
were fairly complex applications, so "it should work" (and IIRC the
patches were publicly available). But I'm sure I'm forgetting some
significant detail and can't go check right now.

>
>
> --
> Best regards,
>  Paul                            mailto:pmiscml@gmail.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"
