Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282081AbRLWWRd>; Sun, 23 Dec 2001 17:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282213AbRLWWRX>; Sun, 23 Dec 2001 17:17:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48648 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282081AbRLWWRO>; Sun, 23 Dec 2001 17:17:14 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch: Support for grub at installation time
Date: 23 Dec 2001 14:17:07 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a05l53$age$1@cesium.transmeta.com>
In-Reply-To: <24997.1009119951@ocs3.intra.ocs.com.au> <3C26448D.A2F5DC1B@Synopsys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C26448D.A2F5DC1B@Synopsys.COM>
By author:    Harald Dunkel <harri@synopsys.COM>
In newsgroup: linux.dev.kernel
> 
> Currently there are just 2 ways to install the freshly build kernel
> outside of the source tree: 'make bzlilo' and 'make install'. Both 
> call lilo, if the executable can be found. Its good to hear that this
> is going to be removed. 
> 

"make install" *DEFAULTS* to calling LILO (in a fairly useless manner,
IMNSHO.)  In practice it calls /sbin/installkernel, which is where you
should put your LILO/GRUB/whathaveyou configuration stuff.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
