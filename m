Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292444AbSBPQ61>; Sat, 16 Feb 2002 11:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292445AbSBPQ6L>; Sat, 16 Feb 2002 11:58:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37126 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292444AbSBPQ57>; Sat, 16 Feb 2002 11:57:59 -0500
Subject: Re: Missed jiffies
To: yodaiken@fsmlabs.com
Date: Sat, 16 Feb 2002 17:11:50 +0000 (GMT)
Cc: george@mvista.com (george anzinger), tyson@rwii.com (Tyson D Sawyer),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020216091405.D29832@hq.fsmlabs.com> from "yodaiken@fsmlabs.com" at Feb 16, 2002 09:14:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16c8NK-0006gR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The SMI is an unbearable abomination and it is an issue that even Microsoft
> has been unable to make Intel respond to properly. It makes Rambus seem brilliant.

To be fair Intel have made it possible to pull this out into processor
control with ACPI. ACPI isnt the greatest bit of design I've ever seen (not
by far) but they addressed the problem.

The BIOS vendors duely decided that the problem was one they didnt mind
having, and it saved code. Especially anyone still doing APM support where
SMI is the only sane implementation approach

