Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUD2T3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUD2T3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbUD2T3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:29:34 -0400
Received: from main.gmane.org ([80.91.224.249]:21979 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264934AbUD2T31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:29:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their	license
Date: Thu, 29 Apr 2004 21:29:24 +0200
Message-ID: <yw1xwu3yeg6j.fsf@kth.se>
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it>
 <20040429190818.GK17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-1832.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:+/19Fi7T182Nvp559DpQNiM9mPo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:

> On Thu, Apr 29, 2004 at 08:40:53PM +0200, Giuliano Colla wrote:
>> As an end user, if I buy a full fledged modem, I get some amount of 
>> proprietary, non GPL, code  which executes within the board or the 
>> PCMCIA card of the modem. The GPL driver may even support the 
>> functionality of downloading a new version of *proprietary* code into 
>> the flash Eprom of the device. The GPL linux driver interfaces with it, 
>> and all is kosher.
>> On the other hand, I have the misfortune of being stuck with a 
>> soft-modem, roughly the *same* proprietary code is provided as a binary 
>> file, and a linux driver (source provided) interfaces with it. In that 
>> case the kernel is flagged as "tainted".
>> 
>> But in both cases, if the driver is poorly written, because of 
>> developer's inadequacy, or because of the proprietary code being poorly 
>> documented and/or implemented, my kernel may go nuts, be it tainted or not.
>> 
>> Can you honestly tell apart the two cases, if you don't make a it a case 
>> of "religion war"?
>
> Yes.  *Especially* outside of religious wars - while fuckup capabilities
> of Joe Random Driver Monkey are unlimited, there is a difference between
> the impact of fuckups in the code that runs on CPU and in the code that
> runs on peripherial.  If nothing else, the latter is less likely to try
> anything cute and tricky with locking.
>
> In other words, with code running on the host CPU  lusers have much, much
> more ways to luse, luse again when trying to "fix" things and make it
> harder to figure out what had caused the bloody mess.

But they could make just as big a mess if they released the source
code, right?  And it would be just as hard to know which driver to
blame.  IF you manage to isolate the fault to one driver, it's
probably easier to see what it's doing, and possibly fix it if the
code is open.  Some driver code I've seen is so messy that it doesn't
really make a difference if you have the code or not.

Don't get me wrong now.  I much prefer open source drivers.  Those can
be compiled on any architecture (unless stupid bugs prevent that,
which I've seen many cases of) and with the newest kernel releases.

-- 
Måns Rullgård
mru@kth.se

