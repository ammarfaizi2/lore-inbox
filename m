Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268914AbRHBMcE>; Thu, 2 Aug 2001 08:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268913AbRHBMby>; Thu, 2 Aug 2001 08:31:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38672 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268914AbRHBMbo>; Thu, 2 Aug 2001 08:31:44 -0400
Subject: Re: 2.4 freezes on init
To: jakub@burgis.fsnet.co.uk (Jakub Burgis)
Date: Thu, 2 Aug 2001 13:33:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Jakub Burgis" at Aug 01, 2001 12:09:50 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SHfP-0000UZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, I believe the kernel image that Mandrake 8's installer uses is
> a 2.4 kernel, yet that works fine. Is this a configuration setting I
> need to toggle, or am I stuck until I switch motherboard?

In the Red Hat case we have seen cases where the installer kernel worked and
not much else did. Install kernels are generally built with the very minimum
of reliance on bios features and for 386.

Typically that means they don't enable common problem items like APM, ACPI
and Athlon optimisation in conjunction with VIA chipsets.

Alan
