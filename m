Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTIHOh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbTIHOh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:37:58 -0400
Received: from ns.suse.de ([195.135.220.2]:63150 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262515AbTIHOh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:37:56 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel header separation
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
	<20030903014908.GB1601@codepoet.org>
	<20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
	<20030905211604.GB16993@codepoet.org>
	<20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk>
	<1063028303.32473.333.camel@hades.cambridge.redhat.com>
	<1063030329.21310.32.camel@dhcp23.swansea.linux.org.uk>
	<20030908142545.GA3926@gtf.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!!  That's a GOOD IDEA!!  Eating a whole FIELD of COUGH MEDICINE
 should make you feel MUCH BETTER!!
Date: Mon, 08 Sep 2003 16:37:54 +0200
In-Reply-To: <20030908142545.GA3926@gtf.org> (Jeff Garzik's message of "Mon,
 8 Sep 2003 10:25:45 -0400")
Message-ID: <je1xurwdkt.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Well, strictly speaking, __u8 is an internal gcc not kernel type.

No, gcc does not define it at all.

> Whenever I see "__u8", I think "non-standard, gcc-specific dependency"

Check out <asm/types.h>.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
