Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311721AbSDCVIV>; Wed, 3 Apr 2002 16:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310789AbSDCVIB>; Wed, 3 Apr 2002 16:08:01 -0500
Received: from mail.webmaster.com ([216.152.64.131]:8117 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S293495AbSDCVH5> convert rfc822-to-8bit; Wed, 3 Apr 2002 16:07:57 -0500
From: David Schwartz <davids@webmaster.com>
To: <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
CC: Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Wed, 3 Apr 2002 13:07:52 -0800
In-Reply-To: <E16soms-0004Au-00@the-village.bc.nu>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020403210754.AAA22091@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Apr 2002 18:43:10 +0100 (BST), Alan Cox wrote:
>>EXPORT_SYMBOL(vfree);
>>EXPORT_SYMBOL(__vmalloc);
>>-EXPORT_SYMBOL_GPL(vmalloc_to_page);
>>+EXPORT_SYMBOL(vmalloc_to_page);
>
>The authors of that code made it GPL. You have no right to change that. Its
>exactly the same as someone taking all your code and making it binary only.
>
>You are
>    -        subverting a digital rights management system
>            [5 years jail in the USA]
>    -        breaking a license

	On the contrary, the GPL specifically gives me the right to modify the code 
to make it more useful to me and distribute those modifications.

>but worse than that you are ignoring the basic moral rights of the authors
>of that code.

	They didn't have to put their code under the GPL if they didn't want to 
allow other people to use and modify it. You can't have it both ways -- 
there's no such thing as 'GPL but with a few extra restrictions I've added to 
the code that everyone's contributed to'.

	DS


