Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135459AbRA1SBh>; Sun, 28 Jan 2001 13:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143675AbRA1SB1>; Sun, 28 Jan 2001 13:01:27 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:44294 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S135459AbRA1SBN>; Sun, 28 Jan 2001 13:01:13 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <200101281739.SAA05979@cave.bitwizard.nl>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 28 Jan 2001 18:01:06 +0000
In-Reply-To: <200101281739.SAA05979@cave.bitwizard.nl> (R.E.Wolff@BitWizard.nl's message of "Sun, 28 Jan 2001 18:39:32 +0100 (MET)")
Message-ID: <m2itmzv9nh.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R.E.Wolff@BitWizard.nl (Rogier Wolff) writes:

> If the firewall operator is sufficiently paranoid, they can say: "We
> don't trust the ECN implementation on our hosts behind the firewall,
> so we want to disable it.".

In which case would the "correct" action not be to zero the ECN bits
of packets passing through the firewall? This would have the effect of
informing the ECN aware hosts (both within and outside the firewall)
that ECN is not available for that connection. This would not prevent
ECN aware systems from connecting.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
