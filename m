Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284694AbRL1Xc6>; Fri, 28 Dec 2001 18:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284537AbRL1Xcs>; Fri, 28 Dec 2001 18:32:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56077 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284694AbRL1Xcc>; Fri, 28 Dec 2001 18:32:32 -0500
Subject: Re: Linux 2.4.18-pre1
To: troels@thule.no (Troels Walsted Hansen)
Date: Fri, 28 Dec 2001 23:43:00 +0000 (GMT)
Cc: andihartmann@freenet.de ('Andreas Hartmann'),
        linux-kernel@vger.kernel.org ('Kernel-Mailingliste')
In-Reply-To: <000e01c18fe4$1b0f7d80$0300000a@samurai> from "Troels Walsted Hansen" at Dec 28, 2001 10:10:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K6eS-0002HR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe the patch you're looking for is last seen in the ac series,
> and not merged with 2.4 mainline due to triggering on unaffected
> motherboards.

The -ac change is mostly a workaround. There is missing locking on the timer
chip handling. Until someone (else) fixes that and we prove that there are
hardware locking issues too, I won't be submitting the workaround because
that'll just stop people fixing the bug
