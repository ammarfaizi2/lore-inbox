Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285517AbRLGUio>; Fri, 7 Dec 2001 15:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285519AbRLGUie>; Fri, 7 Dec 2001 15:38:34 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:13579 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S285517AbRLGUiO>; Fri, 7 Dec 2001 15:38:14 -0500
Message-ID: <3C1128A6.E6F656AF@linux-m68k.org>
Date: Fri, 07 Dec 2001 21:37:58 +0100
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
		<Pine.LNX.4.33.0112071617440.2935-100000@serv>
		<200112071559.fB7FxwR14021@vindaloo.ras.ucalgary.ca>
		<3C1115CD.FD2858EC@linux-m68k.org> <200112072008.fB7K8hA18586@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard Gooch wrote:

> Tell me how the driver no longer works. I repeat: you now get a
> warning. You can still use the driver.

devfs_mk_dir returns an error now, so the driver won't be able to make
new dev nodes available. So far it was legal to manually create a
directory under devfs, now it's suddenly an error.

bye, Roman
