Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbUCSJSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUCSJSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:18:11 -0500
Received: from ns.suse.de ([195.135.220.2]:15801 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261995AbUCSJSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:18:05 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Consistently translate LF to CRLF on serial console
References: <jeekrpbun3.fsf@sykes.suse.de> <1079661779.1947.81.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm meditating on the FORMALDEHYDE and the ASBESTOS leaking into my
 PERSONAL SPACE!!
Date: Fri, 19 Mar 2004 10:18:03 +0100
In-Reply-To: <1079661779.1947.81.camel@gaston> (Benjamin Herrenschmidt's
 message of "Fri, 19 Mar 2004 13:03:00 +1100")
Message-ID: <jek71hb3g4.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2004-03-19 at 10:30, Andreas Schwab wrote:
>> Some serial console drivers translate LF to CRLF, some do LFCR.  This
>> patch changes them to consistently translate to CRLF.
>
> macserial is obsolete (and will be soon removed), please look
> into pmac zilog rather.

I did.

> Also, why did you move the test for
> the transmit buffer empty ? You should at least check there
> is room in it _before_ writing to it

I did that too.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
