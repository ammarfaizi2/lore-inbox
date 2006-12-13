Return-Path: <linux-kernel-owner+w=401wt.eu-S1750961AbWLMVGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWLMVGj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWLMVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:06:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53309 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750960AbWLMVGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:06:37 -0500
Date: Wed, 13 Dec 2006 21:14:36 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] Toshiba TC86C001 IDE driver (take 2)
Message-ID: <20061213211436.50917a26@localhost.localdomain>
In-Reply-To: <200612132319.33588.sshtylyov@ru.mvista.com>
References: <200612132319.33588.sshtylyov@ru.mvista.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 23:19:33 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Behold!  This is the driver for the Toshiba TC86C001 GOKU-S PCI IDE controller,
> completely reworked from the original brain-damaged Toshiba's 2.4 version.
> 
> This single channel UltraDMA/66 controller is very simple in programming, yet
> Toshiba managed to plant many interesting bugs in it.  The particularly nasty
> "limitation 5" (as they call the errata) caused me to abuse the IDE core in a
> possibly most interesting way so far.  However, this is still better than the
> #ifdef mess in drivers/ide/ide-io.c that the original version included  (well,
> it had much more mess)...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Alan Cox <alan@redhat.com>
