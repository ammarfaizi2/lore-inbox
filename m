Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273487AbRJDNcx>; Thu, 4 Oct 2001 09:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273495AbRJDNcm>; Thu, 4 Oct 2001 09:32:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60977 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273487AbRJDNcd>; Thu, 4 Oct 2001 09:32:33 -0400
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu>
	<m14rpg0w4a.fsf@frodo.biederman.org> <jezo77g513.fsf@sykes.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Oct 2001 07:23:21 -0600
In-Reply-To: <jezo77g513.fsf@sykes.suse.de>
Message-ID: <m1r8sjzghi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> |> So any good ideas on how to get the size of linux down?
> 
> How about linux-0.01?

There might be some fodder there, but I doubt it.  I have
played with linux-lite-v1.00 (which is something like linux-1.09).
And couldn't get any really compelling results.  Plus for it to be
useful I would still need to backport all of the driver API's from
2.4.x.

Just for a note, UZI has been ported to x86 as UZIX so a 32KB kernel
(without a network stack is achievable on x86).  If I can get a core
kernel size with no drivers down to 64KB or less I would be happy.

So far I haven't been able to come up with anything satisfying.

Eric
