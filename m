Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbTCIPlh>; Sun, 9 Mar 2003 10:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262527AbTCIPlh>; Sun, 9 Mar 2003 10:41:37 -0500
Received: from jkd.jeetkunedomaster.net ([64.186.37.179]:40834 "EHLO
	jkd.jeetkunedomaster.net") by vger.kernel.org with ESMTP
	id <S262526AbTCIPlg>; Sun, 9 Mar 2003 10:41:36 -0500
From: Jason Straight <jason@JeetKuneDoMaster.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
Date: Sun, 9 Mar 2003 10:52:13 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303090734.XAA01410@adam.yggdrasil.com> <20030308233913.02050257.akpm@digeo.com>
In-Reply-To: <20030308233913.02050257.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303091052.13291.jason@JeetKuneDoMaster.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 March 2003 02:39 am, Andrew Morton wrote:
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> > On another desktop computer (a P3), I get no kernel printk's but user
> > level programs print their output.  For example I see fsck print its
> > output.  However, that computer system hangs after fsck apparently
> > finishes.  The computer with the console problems under 2.5.64bk3
> > boots 2.5.64 and 2.5.64bk1 fine.  I haven't tried 2.5.64bk2 yet.
>
> Did you try adding "console=tty0" to the boot command?  That got broken
> too.

Yeah, got that. I think it's probably the fact that CONFIG_VT_CONSOLE isn't 
defined because it's not in the menuconfig anywhere, putting it in .config 
get's cleaned out by checkconfig.pl. 

-- 
Jason Straight
jason@JeetKuneDoMaster.net
icq: 1796276
pgp: http://www.JeetKuneDoMaster.net/~jason/pubkey.asc

