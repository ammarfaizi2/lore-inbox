Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271431AbRIAVph>; Sat, 1 Sep 2001 17:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271432AbRIAVp3>; Sat, 1 Sep 2001 17:45:29 -0400
Received: from ns.suse.de ([213.95.15.193]:51725 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271431AbRIAVpR>;
	Sat, 1 Sep 2001 17:45:17 -0400
To: Lukas Beeler <lukas.beeler@projectdream.org>
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, lk@tantalophile.demon.co.uk
Subject: Re: Excessive TCP retransmits over lossless, high latency link
In-Reply-To: <20010901195532.B2714@thefinal.cern.ch.suse.lists.linux.kernel> <200109011920.XAA20031@ms2.inr.ac.ru.suse.lists.linux.kernel> <20010901210212.A3361@thefinal.cern.ch.suse.lists.linux.kernel> <20010901223918.A4053@mail.projectdream.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Sep 2001 23:45:29 +0200
In-Reply-To: Lukas Beeler's message of "1 Sep 2001 22:42:42 +0200"
Message-ID: <oupitf2twjq.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Beeler <lukas.beeler@projectdream.org> writes:

> On Sat, Sep 01, 2001 at 09:02:12PM +0100, Jamie Lokier wrote:
> > 
> > If someone would like to do an OS type probe on sdps.demon.co.uk, we
> > will know which OS should be avoided for this kind of connection ;-)
> > 
> 
> it's running solaris 2.5 or 2.5.1

Early unpatched Solaris 2.5 has known problems with its rtt algorithm on 
low bandwidth links.

-Andi

