Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbVLWM4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbVLWM4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 07:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbVLWM4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 07:56:46 -0500
Received: from khc.piap.pl ([195.187.100.11]:5636 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030521AbVLWM4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 07:56:46 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 4k stacks
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 23 Dec 2005 13:56:41 +0100
In-Reply-To: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> (linux-os@analogic.com's
 message of "Thu, 22 Dec 2005 16:53:25 -0500")
Message-ID: <m364pg9dkm.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> Anyway, I tried to enable 4k stacks and the machine would
> not boot past trying to install the first module. It just
> stopped with the interrupts disabled.

Does that happen without your patch as well?

> Anyway, getting down to 20 bytes of stack-space available
> seems to be pretty scary.

More details maybe? .config | grep ^C ? What's on the stack above
the poison?
-- 
Krzysztof Halasa
