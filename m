Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283340AbSAEUwu>; Sat, 5 Jan 2002 15:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283594AbSAEUwc>; Sat, 5 Jan 2002 15:52:32 -0500
Received: from mail.s.netic.de ([212.9.160.11]:63249 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S283340AbSAEUwK>;
	Sat, 5 Jan 2002 15:52:10 -0500
To: jkl@miacid.net
Cc: "Joseph S. Myers" <jsm28@cam.ac.uk>, dewar@gnat.com,
        Dautrevaux@microprocess.com, paulus@samba.org,
        Franz.Sirl-kernel@lauterbach.com, benh@kernel.crashing.org,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, minyard@acm.org, rth@redhat.com,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <Pine.BSI.4.10.10201051208250.8542-100000@hevanet.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Sat, 05 Jan 2002 21:51:43 +0100
In-Reply-To: <Pine.BSI.4.10.10201051208250.8542-100000@hevanet.com>
 (jkl@miacid.net's message of "Sat, 5 Jan 2002 12:17:24 -0800 (PST)")
Message-ID: <87ell48qsg.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jkl@miacid.net writes:

> Forgive me if I haven't been reading the manual carefully enough.  Now can
> we please get a straight answer to the question:  Does GCC provide the
> ability to turn an arbitrary address into a pointer, and if so how do you
> do it?

If you want to do more than what is permitted according to the
documentation (quoted in the message by Joseph S. Myers you replied
to), you have to use machine code insertions in order to get
deterministic effects.  At least this seems to be the consensus so
far.
