Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274965AbRI1Au4>; Thu, 27 Sep 2001 20:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274966AbRI1Auq>; Thu, 27 Sep 2001 20:50:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30995 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274965AbRI1Auk>; Thu, 27 Sep 2001 20:50:40 -0400
Subject: Re: CPU frequency shifting "problems"
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 28 Sep 2001 01:55:42 +0100 (BST)
Cc: padraig@antefacto.com (Padraig Brady), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109271619250.25667-100000@penguin.transmeta.com> from "Linus Torvalds" at Sep 27, 2001 04:23:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mlwM-0005g5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For example, the Intel "SpeedStep" CPU's are completely broken under
> Linux, and real-time will advance at different speeds in DC and AC modes,
> because Intel actually changes the frequency of the TSC _and_ they don't
> document how to figure out that it changed.

The change is APM or ACPI initiated. Intel won't tell anyone anything
useful but Microsoft have published some of the required intel confidential
information which helps a bit
