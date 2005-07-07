Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVGGMTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVGGMTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVGGMPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:15:32 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:19108 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261311AbVGGMNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:13:47 -0400
Date: Thu, 7 Jul 2005 14:13:02 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: raja <vnagaraju@effigent.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipc
Message-ID: <20050707141302.1f40eb89@localhost>
In-Reply-To: <42CD12A7.90106@effigent.net>
References: <42CD12A7.90106@effigent.net>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jul 2005 17:01:51 +0530
raja <vnagaraju@effigent.net> wrote:

> Hi,
> While working with posix ipc i used the function mq_open.
> When i compiled using gcc i am getting error as
>  
> : undefined reference to `mq_open'
> collect2: ld returned 1 exit status
>  
> will you please tell me how to avoid that.

Also this has nothing to do with kernel, stop posting here these
questions.

----

You need to tell GCC to use "libmqueue"... something like this:

	gcc -Wall -O2 -o prog prog.c -lmqueue


Please read this book for other generic programming questions:
	http://www.advancedlinuxprogramming.com/

And use Google.

-- 
	Paolo Ornati
	Linux 2.6.12.2 on x86_64
