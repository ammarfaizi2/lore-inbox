Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSDSLOZ>; Fri, 19 Apr 2002 07:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSDSLOY>; Fri, 19 Apr 2002 07:14:24 -0400
Received: from CPE-203-51-26-88.nsw.bigpond.net.au ([203.51.26.88]:34290 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312248AbSDSLOY>; Fri, 19 Apr 2002 07:14:24 -0400
Message-ID: <3CBFFC09.AF34EE01@eyal.emu.id.au>
Date: Fri, 19 Apr 2002 21:14:17 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre7-ac1: two known problems
In-Reply-To: <200204190916.g3J9G0b01318@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> This is mostly a merge so I could resync stuff with Marcelo.
> Software suspend and other fixes are not merged yet so soft suspend is
> still broken.

Same as in pre5-ac3, patches posted back then.

drivers/net/wan/8253x/8253xutl.c
	does not build

drivers/video/radeonfb.c
	has an unresolved symbol

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
