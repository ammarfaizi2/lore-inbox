Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130367AbQK3QpG>; Thu, 30 Nov 2000 11:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130322AbQK3Qo4>; Thu, 30 Nov 2000 11:44:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:275 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130512AbQK3QnY>; Thu, 30 Nov 2000 11:43:24 -0500
Subject: Re: high load & poor interactivity on fast thread creation
To: a.installe@ieee.org
Date: Thu, 30 Nov 2000 16:12:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, ainstalle@filepool.com
In-Reply-To: <20001130081443.A8118@bach.iverlek.kotnet.org> from "Arnaud Installe" at Nov 30, 2000 08:14:43 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141WKO-0007S9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When creating a lot of Java threads per second linux slows down to a
> crawl.  I don't think this happens on NT, probably because NT doesn't
> create new threads as fast as Linux does.

Also probably the Java implementation on NT is not creating true threads for
each java thread as the IBM java seems to.

> Is there a way (setting ?) to solve this problem ?  Rate-limit the number
> of threads created ?  The problem occurred on linux 2.2, IBM Java 1.1.8.

The programming real answer is replace threads with state machines and all
your stuff runs faster. Thats often easy to say and hard to do.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
