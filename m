Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUBNPJu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 10:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUBNPJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 10:09:50 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:2450 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S261973AbUBNPJs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 10:09:48 -0500
Date: Sat, 14 Feb 2004 16:09:34 +0100
From: Eduard Bloch <edi@gmx.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040214150934.GA5023@zombie.inka.de>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040213032305.GH25499@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by mailgate1.uni-kl.de id i1EF9lRL005030
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Jamie Lokier [Fri, Feb 13 2004, 03:23:05AM]:

> If I create a file using a shell command, what I get depends on which
> terminal I used to create it.  If I am using a terminal which displays
> UTF-8 but ssh to another machine, the other machine assumes the
> terminal is displaying iso-8859-1 even though the other machine's
> default locale is UTF-8.  And so on.

Then you have something wrong in the shell configuration of the remote
machine. I do not see any problems in having a ssh shell opened from a
UTF-8 terminal to a machine where the shell environment is also
configured to use UTF-8 environment.

The only problem that may appear if you deliberatedly configured the
user environment on the other side for latin1, then you would have to
fix it in some way. Eg. configuring LANG depending on SSH* variables in
.bashrc.

Regards,
Eduard.
-- 
Das Merkmal eines kleinen Menschen ist, daß er hochmütig wird, wenn
er merkt, daß man ihn braucht.
		-- Friedl Beutelrock
