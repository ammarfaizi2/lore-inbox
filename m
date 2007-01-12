Return-Path: <linux-kernel-owner+w=401wt.eu-S1751213AbXALPQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbXALPQH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXALPQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:16:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:13467 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbXALPQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:16:05 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mmww7hJa897OXWN++Dk9fKoakHUnJKUp0aOhqTeBf8mb2wOxmy2kZ85tdV7eoV6C4xLfmeSjGXeJUDiiE5/wF+y9I+CYQroQ9vibM8W6rqO5PrG2t2um6xeyCtIMMfhhzXiAd7f5EiMgWRzoIY1GDHtRqA3fHHt2JefOXBdGir0=
Message-ID: <6bffcb0e0701120716h23a1c776je0caeb59c97e8e1a@mail.gmail.com>
Date: Fri, 12 Jan 2007 16:16:03 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Mariusz Kozlowski" <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.20-rc4-mm1
Cc: "Frederik Deweerdt" <deweerdt@free.fr>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, drzeus@drzeus.cx
In-Reply-To: <200701121613.28254.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070111222627.66bb75ab.akpm@osdl.org>
	 <200701121125.58794.m.kozlowski@tuxland.pl>
	 <20070112131800.GE5941@slug>
	 <200701121613.28254.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/07, Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:
> Hello,
>
> > That's because mmc_lock_unlock should depend on CONFIG_KEYS, it uses struct key.
> > Could you try the following patch (compile tested)?
>
> Thanks. Compiles ok but now I run into another problem and the laptop doesn't boot.
> The last thing I see is grub. So no way to test it now. Time to dig some more ;-)

This may help
http://lkml.org/lkml/2007/1/12/45

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
