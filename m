Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275653AbRJAWdJ>; Mon, 1 Oct 2001 18:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275664AbRJAWdA>; Mon, 1 Oct 2001 18:33:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45586 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275653AbRJAWct>; Mon, 1 Oct 2001 18:32:49 -0400
Subject: Re: endless APIC error messages..
To: tadavis@lbl.gov (Thomas Davis)
Date: Mon, 1 Oct 2001 23:38:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3BB8EBD6.6C912E2E@lbl.gov> from "Thomas Davis" at Oct 01, 2001 03:19:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oBhS-0002oI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the APIC message checksumming part is completely in hardware. It might
> be marginal hardware. As long as you dont see any instability, they are
> not a problem - APIC messages are retried until delivered. (Ingo Molnar) 

APIC checksums are not it appears stunningly robust. You also want a
-ac kernel or 2.4.10 to handle the apic event rerun bug
