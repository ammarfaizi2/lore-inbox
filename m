Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292674AbSBURmS>; Thu, 21 Feb 2002 12:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292673AbSBURmK>; Thu, 21 Feb 2002 12:42:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50695 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292675AbSBURlK>; Thu, 21 Feb 2002 12:41:10 -0500
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 21 Feb 2002 17:50:30 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C752F41.4050303@evision-ventures.com> from "Martin Dalecki" at Feb 21, 2002 06:32:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dxMU-0007eZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In esp using a CardBus ide adapter will give you after first
> plug: /dev/hdc, after second plug /dev/hde and so on... on 2.4.17.

Just tried that - its working for me in 2.4.18pre - do you know what
triggers that ?

> I'm just rying to clarify the code-flow before stuff like the above
> can be cleaned up.

The problem is if you keep cleaning up stuff which was there ready to
merge new stuff, then its impossible to merge new stuff. At the moment
there are two many cooks involved in that code. It all needs to go via one
person and in an ordered way - even if it isnt Andre since Linus and Andre
aren't the most compatible people 8)
