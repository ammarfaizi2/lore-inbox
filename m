Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTCCP2R>; Mon, 3 Mar 2003 10:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbTCCP2Q>; Mon, 3 Mar 2003 10:28:16 -0500
Received: from angband.namesys.com ([212.16.7.85]:25473 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265725AbTCCP2N>; Mon, 3 Mar 2003 10:28:13 -0500
Date: Mon, 3 Mar 2003 18:38:38 +0300
From: Oleg Drokin <green@namesys.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, mason@suse.com, trond.myklebust@fys.uio.no,
       jaharkes@cs.cmu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 iget5_locked port attempt to 2.4
Message-ID: <20030303183838.B4513@namesys.com>
References: <20030220175309.A23616@namesys.com> <20030220154924.7171cbd7.akpm@digeo.com> <20030221220341.A9325@namesys.com> <20030221200440.GA23699@delft.aura.cs.cmu.edu> <20030303170924.B3371@namesys.com> <1046708741.6509.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046708741.6509.5.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 03, 2003 at 04:25:41PM +0000, Alan Cox wrote:
> >    It's me again, I basically got no reply for this iget5_locked patch
> >    I have now. Would there be any objections if I try push it to Marcelo
> >    tomorrow? ;)
> I just binned it. Certainly its not the kind of stuff I want to test in -ac, 
> too many VFS changes outside reiserfs

Andrew Morton said "iget5_locked() looks simple enough, and as far as I can
tell does not change any existing code - it just adds new stuff.",
also this code (in its 2.5 incarnation) was tested in 2.5 for long time already.
Also it fixes real bug (and while I have another reiserfs-only fix for the bug,
it is fairly inelegant).

Bye,
    Oleg
