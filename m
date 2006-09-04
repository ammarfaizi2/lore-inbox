Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWIDImd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWIDImd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWIDImc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:42:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:6091 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751157AbWIDImb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:42:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qcFNrK4o3iD6X+1tfvSoqoENOBboNbJr/PmSSMtYpi8u3fCM7lfXij3JQ8hoTNLgmnovS9j8HaInI8ttJAY/5uKs0cLnpJK6l2HNDY9T7sSRobMKPtm+XhLJTuP9HxUSALWZBWw8i3Q57KedLwo1s+Hc9WiMuC0oG1StPgf8JK8=
Message-ID: <9e0cf0bf0609040142y795f9252sd7a8ca1ce8fdde75@mail.gmail.com>
Date: Mon, 4 Sep 2006 11:42:30 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: schwidefsky@de.ibm.com
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
Cc: "Nigel Cunningham" <ncunningham@linuxmail.org>,
       "Paul Mackerras" <paulus@samba.org>, "Andi Kleen" <ak@suse.de>,
       "Matt Domsch" <Matt_Domsch@dell.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org, rc@rc0.org.uk,
       spyro@f2s.com, rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
In-Reply-To: <1157358727.5078.11.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609040050.13410.alon.barlev@gmail.com>
	 <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
	 <1157338220.10336.147.camel@nigel.suspend2.net>
	 <1157358727.5078.11.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/06, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> The reason is our initial address space layout for the very first kernel
> images. Now it is hard to changed because the different ipl tools rely
> on the layout. We choose to add a few more bytes than 256 because on
> s390 we potentially have many devices. The dasd= parameter can really be
> big.

Thanks for the explanation... I've been curios as well :)
Can you please check if this patch is OK in s390 environment?

Best Regards,
Alon Bar-Lev.

-- 
VGER BF report: H 0
