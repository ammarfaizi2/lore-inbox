Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312275AbSDCR2K>; Wed, 3 Apr 2002 12:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312269AbSDCR2B>; Wed, 3 Apr 2002 12:28:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31492 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312275AbSDCR1u>; Wed, 3 Apr 2002 12:27:50 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: andrea@suse.de (Andrea Arcangeli)
Date: Wed, 3 Apr 2002 18:43:10 +0100 (BST)
Cc: arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop), linux-kernel@vger.kernel.org
In-Reply-To: <20020403182118.A10959@dualathlon.random> from "Andrea Arcangeli" at Apr 03, 2002 06:21:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16soms-0004Au-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  EXPORT_SYMBOL(vfree);
>  EXPORT_SYMBOL(__vmalloc);
> -EXPORT_SYMBOL_GPL(vmalloc_to_page);
> +EXPORT_SYMBOL(vmalloc_to_page);

The authors of that code made it GPL. You have no right to change that. Its
exactly the same as someone taking all your code and making it binary only.

You are
	-	subverting a digital rights management system
			[5 years jail in the USA]
	-	breaking a license

but worse than that you are ignoring the basic moral rights of the authors
of that code.

Alan


