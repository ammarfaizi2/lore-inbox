Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTKKJse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 04:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTKKJse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 04:48:34 -0500
Received: from smtp4.cern.ch ([137.138.131.165]:54159 "EHLO smtp4.cern.ch")
	by vger.kernel.org with ESMTP id S264277AbTKKJsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 04:48:32 -0500
Keywords: CERN SpamKiller Note: -51
From: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: PCI with SiS: Cannot allocate resource.
Date: Tue, 11 Nov 2003 10:48:29 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311101557020.2097-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0311101557020.2097-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311111048.30130.Alexander.Zviagine@cern.ch>
X-OriginalArrivalTime: 11 Nov 2003 09:48:30.0370 (UTC) FILETIME=[F67FA020:01C3A838]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On Tuesday 11 November 2003 04:48, Davide Libenzi wrote:
>
> Running really out of options here. The dmesg shows that you're sharing
> the IRQ5 but it does not even show up in your int list. Your card seems to
> be sharing IRQ 5 with:
>
> PCI: Sharing IRQ 5 with 0000:00:01.6
> PCI: Sharing IRQ 5 with 0000:00:0c.1
>
> IIRC one is the modem, and I do not remember the other one. If your BIOS
> has the option to shut those device off, you can try that. Also you can
> try (if you can) to change the interrupt pin.

Two 'no'. I can not disable it in BIOS. And I will not touch the hardware!

Is it really nothing can be done? I can apply debug patches, if somebody will 
provide them...

Thanks for your time anyway!
A bit disappointed Alexander.

