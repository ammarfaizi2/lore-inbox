Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWF2SRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWF2SRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWF2SRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:17:49 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:59999 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751115AbWF2SRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:17:48 -0400
Message-ID: <44A41946.7070201@tls.msk.ru>
Date: Thu, 29 Jun 2006 22:17:42 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>
Subject: Re: [PATCH 07/13] SERIAL: PARPORT_SERIAL should depend on SERIAL_8250_PCI
References: <20060620114527.934114000@sous-sol.org> <20060620114733.957367000@sous-sol.org> <44A40E68.9080906@tls.msk.ru> <20060629173710.GE9709@flint.arm.linux.org.uk> <20060629181216.GY11588@sequoia.sous-sol.org>
In-Reply-To: <20060629181216.GY11588@sequoia.sous-sol.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Blah.. the CC list went wrong while copying original email from
 lkml.org.  That was entirely my fault, and I'm terrible sorry
 for that.  Erroneous entries removed.  But the CC list is still
 too long...]

Chris Wright wrote:
> * Russell King (rmk+lkml@arm.linux.org.uk) wrote:
>> On Thu, Jun 29, 2006 at 09:31:20PM +0400, Michael Tokarev wrote:
>>> I've no idea how this patch slipped into 2.6.16 -stable queue in the
>>> first place... ;)
> 
> When Russell sent the patch to stable he said "For the stable branches"
> which I took to mean both 2.6.16 and 2.6.17, so I added to both.

Aha!

>> Probably because I didn't pay enough attention to the review mails.
>> I wasn't expecting it to go into 2.6.16, so thought little of it.
> 
> I'll add a revert patch for 2.6.16.  Sound OK?

Well, it definitely should be reverted for 2.6.16, yes.

Thanks.

/mjt
