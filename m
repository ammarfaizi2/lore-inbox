Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbSKCCQw>; Sat, 2 Nov 2002 21:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSKCCQw>; Sat, 2 Nov 2002 21:16:52 -0500
Received: from almesberger.net ([63.105.73.239]:56072 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261558AbSKCCQv>; Sat, 2 Nov 2002 21:16:51 -0500
Date: Sat, 2 Nov 2002 23:23:08 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Krishna Kumar <kumarkr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
Message-ID: <20021102232308.A4482@almesberger.net>
References: <OFB7772DA2.01708E94-ON87256C65.006EDAE7@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB7772DA2.01708E94-ON87256C65.006EDAE7@boulder.ibm.com>; from kumarkr@us.ibm.com on Sat, Nov 02, 2002 at 01:13:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc: trimmed ]

Krishna Kumar wrote:
> userspace -  what happens when signals (KILL) are sent to that process ?

They die, as they should.

> We don't want the home agent functionality to stop in that case, even
> if it is a system admin error.

So what makes the home agent so much more important than, say, named,
pppd, gated, portmap, inetd, sendmail, sshd, etc. ?

A much more common admin mistake would be to reboot the wrong box, or
to disconnect the wrong cable, and you're powerless against this too.

If all else fails, add this to ~root/.bashrc:
alias kill='echo "Sorry, you'\''re too dumb for this"; false'
:-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
