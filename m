Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280716AbRKGAVe>; Tue, 6 Nov 2001 19:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280713AbRKGAVO>; Tue, 6 Nov 2001 19:21:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45583 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280709AbRKGAVD>; Tue, 6 Nov 2001 19:21:03 -0500
Subject: Re: Using %cr2 to reference "current"
To: dalecki@evision.ag
Date: Wed, 7 Nov 2001 00:27:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3BE883BF.1025EC08@evision-ventures.com> from "Martin Dalecki" at Nov 07, 2001 01:43:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161GZT-0002Ln-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please count the removal of the *very* sparse read_ahead array as
> well (patch went to this list a long time ago) in.
> It doesn't cost anything and saves some few pages depending on the
> number of drivers you have loaded... (Well in comparision to the above
> that's nit picking, but...) 

Sounds quite believable. Several of the hashes are oversize too it seems

> And then there is the overloaded struct inde. It would be worth
> quite a bit of memmory to not overlay the private,filesystem 
> specific parts but to attach them by a pointer instead, in esp.

Thats what -ac has started doing. Al Viro has done the worst case ones
so far.

Alan
