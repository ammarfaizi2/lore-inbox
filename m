Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbTIHQEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbTIHQEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:04:49 -0400
Received: from ns.suse.de ([195.135.220.2]:2262 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262821AbTIHQEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:04:47 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.23-pre3] Possible bug in fs/buffer.c
References: <200309081715.09657@bilbo.math.uni-mannheim.de>
	<je3cf7uw0f.fsf@sykes.suse.de>
	<1063036721.21084.55.camel@dhcp23.swansea.linux.org.uk>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I had a lease on an OEDIPUS COMPLEX back in '81...
Date: Mon, 08 Sep 2003 18:04:45 +0200
In-Reply-To: <1063036721.21084.55.camel@dhcp23.swansea.linux.org.uk> (Alan
 Cox's message of "Mon, 08 Sep 2003 16:58:42 +0100")
Message-ID: <jellsztgf6.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2003-09-08 at 16:42, Andreas Schwab wrote:
>> It's neither ugly, nor bogus.  The only 100% reliable way to assign the
>> maximum value to an unsigned integer is to use -1.
>
> Its not 100% reliable either 8).

Could you please elaborate?  Casting -1 to an unsigned type is guaranteed
to yield the maximum value for that type, at least since C89, but I think
even K&R C did get it right.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
