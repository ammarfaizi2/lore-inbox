Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275321AbRIZQsi>; Wed, 26 Sep 2001 12:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275320AbRIZQs2>; Wed, 26 Sep 2001 12:48:28 -0400
Received: from zeus.kernel.org ([204.152.189.113]:2009 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S275322AbRIZQsM>;
	Wed, 26 Sep 2001 12:48:12 -0400
Subject: Re: Ethernet Error Correction
To: clock@atrey.karlin.mff.cuni.cz (Karel Kulhavy)
Date: Wed, 26 Sep 2001 17:51:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz> from "Karel Kulhavy" at Sep 25, 2001 10:34:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mHud-0000w4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> there is a fog of course. But dropping a single bit in 1500 bytes makes a lot
> of mess.  There is also unsused src and dest address (12 bytes) which is
> obvious and superfluous.  What about kicking the address off and putting some
> error correction codes (like Hamming) into it and putting the cards into
> promisc mode?  It would make the link work on bigger distance and on thicker
> mist.  We could even dynamically change the ECC/data ratio for example with
> Reed Solomon Codes. Ethernet modulation is strong gainst sync dropouts so the
> bits usually remain their place, just some of them happen to flip. We could
> also kick the "lenght" field because end of packet is recognized by a pulse
> longer than 200ns, not neither by ECC nor by the length (am I right?).

You could do this by picking the right cards turning off CRC filtering and
doing a lot of work in software yes
