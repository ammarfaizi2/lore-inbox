Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266512AbSLJBqm>; Mon, 9 Dec 2002 20:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266527AbSLJBql>; Mon, 9 Dec 2002 20:46:41 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:14902 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S266512AbSLJBql>; Mon, 9 Dec 2002 20:46:41 -0500
Date: Mon, 9 Dec 2002 20:54:23 -0500
From: Daniel Franke <daniel@franke.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Radeon DRI w/ large memory
Message-ID: <20021210015423.GA469@silmaril>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021209224553.GA469@silmaril>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021209224553.GA469@silmaril>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 05:45:53PM -0500, I wrote:
> I recently upgraded my memory to 1GB and compiled 4GB large memory support
> into the kernel.  Now, my display freezes when I try to use DRI with my
> ATI Radeon VE (Radeon 7000 chipset IIRC).  The machine is still responsive
> to the LAN, but even if I kill X, the display remains frozen.  Disabling
> large memory support makes the problem go away.
> 
> I use 2.4.20-ac1

Everything seems fine when I use vanilla 2.4.20.  Hightower from #kernelnewbies
tells me that there is a known bug in -ac with Radeon DRI and 2.4.20-ac1, but
that as far as he is aware, the bug occurs regardless of the large memory 
setting.  However, since the bug goes away when I switch to the linus tree, I
will assume that it is the same bug.  If I see otherwise when the known bug is
supposedly fixed, I will post further information.
