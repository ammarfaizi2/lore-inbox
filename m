Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264038AbTCXCCG>; Sun, 23 Mar 2003 21:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264039AbTCXCCG>; Sun, 23 Mar 2003 21:02:06 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:31962 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264038AbTCXCCF>; Sun, 23 Mar 2003 21:02:05 -0500
To: Eli Carter <eli.carter@inet.com>
Cc: Mike Dresser <mdresser_l@windsormachine.com>, linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
References: <Pine.LNX.4.33.0303201138000.29061-100000@router.windsormachine.com>
	<3E79FFAD.3040904@inet.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 24 Mar 2003 11:12:24 +0900
In-Reply-To: <3E79FFAD.3040904@inet.com>
Message-ID: <buowuipzf5j.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter <eli.carter@inet.com> writes:
> So, who can beat his 15.10 bogomips?  Anyone run <1 bogomips?

The normal systems I develop for have 4-6 bogomips (NEC V850E/MA1 @50MHz).

For debugging I often run linux on gdb's simulator, which probably has
somewhere under 1 bogomips (the number reported is not correct because I
have to lie to the kernel about the clock interrupt rate, as it can't
handle the real value).  It's still quite usable interactively though
(actually 2.5.x feels noticably better than 2.4.x in this situation)...

-Miles
-- 
97% of everything is grunge
