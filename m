Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289086AbSAIXzF>; Wed, 9 Jan 2002 18:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289088AbSAIXyz>; Wed, 9 Jan 2002 18:54:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33291 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289086AbSAIXyn>; Wed, 9 Jan 2002 18:54:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Date: 9 Jan 2002 15:54:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1il7j$hjl$1@cesium.transmeta.com>
In-Reply-To: <20020109174637.A1742@thyrsus.com> <Pine.LNX.4.33.0201092325280.31502-100000@sphinx.mythic-beasts.com> <20020109182902.A2804@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020109182902.A2804@thyrsus.com>
By author:    "Eric S. Raymond" <esr@thyrsus.com>
In newsgroup: linux.dev.kernel
> 
> OK.  One more time.
> 
> The autoconfigurator is *not* mean to be run at boot time, or as root.
> 
> It is intended to be run by ordinary users, after system boot time.
> This is so they can configure and experimentally build kernels without
> incurring the "oops..." risks of going root.
> 
> Therefore, the above 'solution' is not acceptable.
> 

If /var/run/dmidata [or whatever you call it] isn't available, put an
error box on the screen and say "complain to your distribution
vendor."

End of story.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
