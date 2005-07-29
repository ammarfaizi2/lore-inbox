Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVG2U7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVG2U7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVG2U67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:58:59 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:14352 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S262256AbVG2U6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:58:08 -0400
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Cc: mingo@elte.hu, mpm@selenic.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, akpm@osdl.org, chrisw@osdl.org
Subject: Re: Broke nice range for RLIMIT NICE
References: <87u0idhdju.fsf@amaterasu.srvr.nix>
	<12213.1122650084@www71.gmx.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: the definitive fritterware.
Date: Fri, 29 Jul 2005 21:57:48 +0100
In-Reply-To: <12213.1122650084@www71.gmx.net> (Michael Kerrisk's message of
 "Fri, 29 Jul 2005 17:14:44 +0200 (MEST)")
Message-ID: <871x5hgwj7.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Michael Kerrisk uttered the following:
>> On 29 Jul 2005, Michael Kerrisk stated:
>> > Yes, as noted in my earlier message -- at the moment RLIMIT_NICE 
>> > still isn't in the current glibc snapshot...
>> 
>> According to traffic on libc-hacker, Ulrich committed it on Jun 20
>> (along with RLIMIT_RTPRIO support).
> 
> I (now) see the message that you mean on libc-hacker, nevertheless,
> looking at the glibc-2.3-20050725 snapshot, these two constants do 
> not appear anywhere.  (Strange!)

That just means it hasn't gone into the stable branch (yet?); since
that's bugfix-only and changes are bursted in intermittently by Roland,
that's not very surprising.

But if you look in HEAD (2.4-to-be), you'll see it.

-- 
`Tor employs several thousand editors who they keep in dank
 subterranean editing facilities not unlike Moria' -- James Nicoll 
