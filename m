Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262509AbTCIOGJ>; Sun, 9 Mar 2003 09:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbTCIOGJ>; Sun, 9 Mar 2003 09:06:09 -0500
Received: from jkd.jeetkunedomaster.net ([64.186.37.179]:21889 "EHLO
	jkd.jeetkunedomaster.net") by vger.kernel.org with ESMTP
	id <S262509AbTCIOGI>; Sun, 9 Mar 2003 09:06:08 -0500
From: Jason Straight <jason@JeetKuneDoMaster.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
Date: Sun, 9 Mar 2003 09:16:44 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303090144.11339.jason@JeetKuneDoMaster.net> <20030308225522.4e7301ea.akpm@digeo.com>
In-Reply-To: <20030308225522.4e7301ea.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303090916.44475.jason@JeetKuneDoMaster.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 March 2003 01:55 am, Andrew Morton wrote:
> Jason Straight <jason@JeetKuneDoMaster.net> wrote:
> > I get the usual loading kernel, uncompressing, booting.
> >
> > After it tells me it's booting the kernel I see no more screen activity
> > at all, but it is finishing the boot process. It does leave that text on
> > the screen, but nothing more.
> >
> > I don't have any odd type console like serial or paralell unless there's
> > something I mistakenly turned on.
>
> You need to enable "Support for console on virtual terminal",
> aka CONFIG_VT_CONSOLE.
>
> Maybe someone should fix that.

I put it in the config but it gets removed by checkconfig.pl when I make, so 
I'm guessing there's more missing than just the line in the config. :-/

-- 
Jason Straight
jason@JeetKuneDoMaster.net
icq: 1796276
pgp: http://www.JeetKuneDoMaster.net/~jason/pubkey.asc

