Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272473AbRI0MFF>; Thu, 27 Sep 2001 08:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272484AbRI0ME4>; Thu, 27 Sep 2001 08:04:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54540 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272473AbRI0MEq>; Thu, 27 Sep 2001 08:04:46 -0400
Subject: Re: Binary only module overview
To: greg@kroah.com (Greg KH)
Date: Thu, 27 Sep 2001 13:09:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        crispin@wirex.com, linux-security-module@wirex.com
In-Reply-To: <20010926164643.B21369@kroah.com> from "Greg KH" at Sep 26, 2001 04:46:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mZyp-0003om-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or place some kind of markings on the symbols/functions that the LSM
> code exports stating that these symbols/functions can only be called
> from GPL licensed code.

GPL_EXPORT_SYM is coming, has been discussed and tentatively agreed upon
so that we can for example have libraries of GPL code that are GPL module
only usable, while still exporting clear interfaces for nonfree users when
appropriate (eg device drivers)

Turning existing in kernel exports GPL_ all of a sudden is not going to
happen.
