Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVGXVIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVGXVIh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVGXVIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:08:37 -0400
Received: from [85.8.12.41] ([85.8.12.41]:63366 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261315AbVGXVIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:08:34 -0400
Message-ID: <42E40350.203@drzeus.cx>
Date: Sun, 24 Jul 2005 23:08:32 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-0.1.fc5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: IRQ routing problem in 2.6.10-rc2
References: <42E395F6.8070301@drzeus.cx> <9a87484905072407164f0e0eb5@mail.gmail.com>
In-Reply-To: <9a87484905072407164f0e0eb5@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>
>Have you tried the suggestion given "... As a temporary workaround,
>the "pci=routeirq" argument..." ?
>You could also try the pci=noacpi boot option to see if that changes anything.
>  
>

No, I missed that one. The machine works fine with either of those two
options. I sent a comment with lspci to Bjorn Helgaas as suggested.

>Also, that's a fairly old kernel you have there, could you try
>2.6.13-rc3, 2.6.13-rc3-git6 or 2.6.13-rc3-mm1 ?
>
>  
>

I discovered the problem running 2.6.12. I only tried these kernels to
pinpoint where the problem began.

Rgds
Pierre


