Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265595AbUBPOYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUBPOYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:24:31 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:8845 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S265595AbUBPOY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:24:29 -0500
Date: Mon, 16 Feb 2004 15:24:11 +0100
From: Eduard Bloch <edi@gmx.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <20040216142411.GA3474@zombie.inka.de>
References: <Pine.LNX.4.58.0402151545030.443@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402151545030.443@neptune.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin Pascal!
Pascal Schmidt schrieb am Sunday, den 15. February 2004:

> >>    iso-8859-1 for that virtual terminal, but the keyboard remained
> >>    stuck in UTF-8 for _all_ virtual terminals.
> > kbd_mode -a to reset to ASCII mode.
> 
> And as I just figured out, loadkeys has to be invoked again, also.
> 
> I can go to utf-8 with:
> 
> 	setfont lat0-16
> 	kbd_mode -u
> 	loadkeys de-latin1-nodeadkeys

When I do this, I still cannot enter unicode chars "as usual". I see
them, mutt (for example) displays everything correct with a UTF-8
locale. However, I cannot insert them correctly. When I use vim, I have
to press another key (eg. Space) 2..4 times after an umlaut was pressed,
only then the char appears.

Needless to say that the same applications work fine in X with the same
UTF-8 locale.

Regards,
Eduard.
-- 
Lob ist eine gewaltige Antriebskraft, dessen Zauber seine Wirkung nie
verfehlt.
		-- Andor Foldes
