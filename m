Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275013AbTHQERi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 00:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275016AbTHQERi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 00:17:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:4995 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S275013AbTHQERg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 00:17:36 -0400
Date: Sun, 17 Aug 2003 05:16:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: insecure <insecure@mail.od.ua>
Cc: Martin List-Petersen <martin@list-petersen.se>,
       "Bryan O'Sullivan" <bos@serpentine.com>,
       Christian Axelsson <smiler@lanil.mine.nu>, linux-kernel@vger.kernel.org
Subject: Re: Centrino support
Message-ID: <20030817041654.GA32559@mail.jlokier.co.uk>
References: <m2wude3i2y.fsf@tnuctip.rychter.com> <1060980941.29086.25.camel@serpentine.internal.keyresearch.com> <1060982549.15347.30.camel@loke> <200308170132.50312.insecure@mail.od.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308170132.50312.insecure@mail.od.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

insecure wrote:
> This makes it difficult to open-source code that enforces limits on
> the power levels, frequency channels and other parameters of the radio
> transmitter.  See
> 
> http://ftp.fcc.gov/Bureaus/Engineering_Technology/Orders/2001/fcc01264.pdf
> 
> for the specific FCC regulation.

I have just read that FCC regulation.

It doesn't prevent open-sourcing the code.  It does require that each
software-defined radio must have some kind of authentication mechanism
to ensure that unapproved software cannot be loaded on to the device.

It seems to me that distributing a binary, which is easily modified by
users, (as proven by all the game patches and application cracks out
there), does _not_ satisfy the FCC regulation.

The only way to satisfy the regulation is to have an authentication
mechanism of some kind, so that the radio will not operate with
unapproved software.

If Intel have not implemented an authentication mechanism, then they
are not compliance with the FCC regulation as I read it because it
won't be long before some enterprising user patches the firmware and
makes the radio behave in an unapproved, possibly RF unsafe manner.

If Intel have implement such a mechanism, then regulation is no excuse
for them to not release the source code.

-- Jamie
