Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285475AbRLGTSS>; Fri, 7 Dec 2001 14:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285474AbRLGTSI>; Fri, 7 Dec 2001 14:18:08 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:33031 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S285467AbRLGTRy>; Fri, 7 Dec 2001 14:17:54 -0500
Message-ID: <3C1115CD.FD2858EC@linux-m68k.org>
Date: Fri, 07 Dec 2001 20:17:33 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Rene Rebe <rene.rebe@gmx.net>, linux-kernel@vger.kernel.org,
        alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.33.0112071617440.2935-100000@serv> <200112071559.fB7FxwR14021@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard Gooch wrote:

> Well, no, it was never a valid option. It was always a bug. In any
> case, the stricter behaviour isn't preventing people from using their
> drivers, it's just issuing a warning. The user-space created device
> node still works.

But the driver doesn't. You changed the driver API in subtle way! You
cannot change the behaviour of devfs_register during 2.4. Do whatever
you want in 2.5, but drivers depend on the current behaviour and devfs
has to be fixed not these drivers.

bye, Roman
