Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273051AbRIIVJQ>; Sun, 9 Sep 2001 17:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273052AbRIIVJG>; Sun, 9 Sep 2001 17:09:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28684 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273051AbRIIVI7>; Sun, 9 Sep 2001 17:08:59 -0400
Date: Sun, 9 Sep 2001 23:09:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
Message-ID: <20010909230920.A23392@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010909170206.A3245@redhat.com>; from bcrl@redhat.com on Sun, Sep 09, 2001 at 05:02:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > and send results to me? It should be rather easy to emulate initial
> > handshake and use mars (netware emulator) to boot workstation...
> 
> No need -- just search around for a copy of rpld.  I've got a few 
> SiS based boards that netboot via rpl which rpld manages to handle 
> like a charm.  Cheers,

Unfortunately, it is not that simple:

(From rpld-1.7/README:)

RPLD implements the IBM RIPL protocol, used to network boot some
machines. It
DOES NOT implement the Novell style RPL/IPX protocol.  If your are not
sure
which protocol you are using see the section "Troubleshooting".

And, indeed, it does not work with Novell bootrom. If you have
different version, please let me know...
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
