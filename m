Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284436AbRLIVQl>; Sun, 9 Dec 2001 16:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284440AbRLIVQb>; Sun, 9 Dec 2001 16:16:31 -0500
Received: from vp242.dmp01.sea.blarg.net ([206.124.142.242]:50843 "EHLO
	mail.rudedog.org") by vger.kernel.org with ESMTP id <S284436AbRLIVQ1>;
	Sun, 9 Dec 2001 16:16:27 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: Bizarre TCP throughput problems
In-Reply-To: <3C133AEA.50605@colorfullife.com>
From: Dave Carrigan <dave@rudedog.org>
Organization: Rudedog.org
Date: 09 Dec 2001 13:16:26 -0800
In-Reply-To: <3C133AEA.50605@colorfullife.com>
Message-ID: <877krwjdqt.fsf@cbgb.rudedog.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> Could you try:
> - if concurrent flood pings between cbgb an dpern improve the throughput
>   with 2.4.16 and HTTP?
> 
>  # ping -f pern
> or
> # ping -f cbdb

This didn't seem to make a difference.

> - Could you check what happens with 2.4.16 if you revert to the tulip
>   driver from 2.4.14?

This definitely made a difference. I compiled the 2.4.14 tulip.o as a
module for the 2.4.16 kernel. If I insmod the 2.4.14 version, TCP
throughput is fine. If I take the interface down then insmod the 2.4.16
version, TCP throughput is very poor.

Regards,

-- 
Dave Carrigan (dave@rudedog.org)            | Yow! If I pull this SWITCH I'll
UNIX-Apache-Perl-Linux-Firewalls-LDAP-C-DNS | be RITA HAYWORTH!!  Or a
Seattle, WA, USA                            | SCIENTOLOGIST!
http://www.rudedog.org/                     | 
