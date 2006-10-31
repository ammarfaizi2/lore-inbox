Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422974AbWJaIrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974AbWJaIrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422975AbWJaIrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:47:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:50055 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422974AbWJaIrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:47:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=EqF5JMf+07D1yH97Ow/TF6FfKCqZtUgUTsx4O2XWTky9C+eTWVRfpHRNEbyDEAlOj2gvJBezMGcVX2Y2vIDXYriHj2CiNIlf1cC/SI2OSfxPZ7KprJXjGvyhplsxG0n51NETZuCteE/HXvaWsPbsFRHFpr4QF2G2d1qkSB6CFKA=
Message-ID: <45470DB8.5020906@innova-card.com>
Date: Tue, 31 Oct 2006 09:47:52 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
References: <20061026174858.b7c5eab1.maxextreme@gmail.com>	 <20061026220703.37182521.akpm@osdl.org>	 <4545C756.30403@innova-card.com> <653402b90610300553t405c67e6u69dee3c83c22dae5@mail.gmail.com>
In-Reply-To: <653402b90610300553t405c67e6u69dee3c83c22dae5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
> Again: Please read LDD3. It explains it well. Read all the "Remapping
> RAM" chapter and you will understand what I've done, or just try to
> remap RAM yourself with remap_pfn_range. 

Well, I'm trying to get an explanation here and here is what I get
from you:

MO  > LDD3 states it must work like this. (Note: it doesn't explain
      why though)
FBH > Weird I read the implementation of remap_pfn_range() and it 
      doesn't seem to have such restriction, I'm wondering how
      things work...
MO  > Again it's stated in LDD3, read again.

Do you really think you explain anything with such replies ?

Fortunately, Hugh Dickins gives a hint and it appears that the
restriction doesn't hold anymore.

> (I really tried it using
> different ways and I couldn't map it with remap_pfn_range, it returns
> you a place full with zeros, as LDD3 states).

I'm really wondering how did you test the thing... ;)

bye
		Franck
