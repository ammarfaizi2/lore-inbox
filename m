Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136411AbREGR2U>; Mon, 7 May 2001 13:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136426AbREGR2K>; Mon, 7 May 2001 13:28:10 -0400
Received: from t2.redhat.com ([199.183.24.243]:46586 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S136411AbREGR2D>; Mon, 7 May 2001 13:28:03 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0105071003330.12733-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.21.0105071003330.12733-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Gerst <bgerst@didntduck.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 May 2001 18:27:35 +0100
Message-ID: <12402.989256455@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  If anybody has such a beast, please try this kernel patch _and_
> running the F0 0F bug-producing program (search for it on the 'net -
> it must be out there somewhere) to verify that the code still
> correctly handles that case. 

Something along the lines of:

echo "unsigned long main=0xf00fc7c8;" > f00fbug.c ; make f00fbug

--
dwmw2


