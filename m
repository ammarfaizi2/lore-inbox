Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTIHPXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbTIHPXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:23:35 -0400
Received: from ns.suse.de ([195.135.220.2]:57029 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262489AbTIHPXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:23:33 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel header separation
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
	<20030903014908.GB1601@codepoet.org>
	<20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
	<20030905211604.GB16993@codepoet.org>
	<20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk>
	<1063028303.32473.333.camel@hades.cambridge.redhat.com>
	<1063030329.21310.32.camel@dhcp23.swansea.linux.org.uk>
	<20030908142545.GA3926@gtf.org> <20030908143249.GA4462@gtf.org>
	<20030908144232.GP18654@parcelfarce.linux.theplanet.co.uk>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  Am I having fun yet?
Date: Mon, 08 Sep 2003 17:22:56 +0200
In-Reply-To: <20030908144232.GP18654@parcelfarce.linux.theplanet.co.uk> (Matthew
 Wilcox's message of "Mon, 8 Sep 2003 15:42:32 +0100")
Message-ID: <jeoexvuwxb.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> On Mon, Sep 08, 2003 at 10:32:49AM -0400, Jeff Garzik wrote:
>> On Mon, Sep 08, 2003 at 10:25:45AM -0400, Jeff Garzik wrote:
>> > Whenever I see "__u8", I think "non-standard, gcc-specific dependency"
>> 
>> Ignore this, I stand corrected:  these are kernel types.
>> 
>> Regardless, I still prefer the C99 size-specific types, as they are the
>> most portable across all compilers, and you can depend on the compiler
>> to provide them for you.  No need to define them yourself.
>
> bzzt.  glibc provides them, not gcc.

Actually, a freestanding environment is required (in C99) to provide
<stdint.h>.  gcc isn't quite there yet.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
