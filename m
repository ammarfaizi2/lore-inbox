Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266875AbUKAPqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266875AbUKAPqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbUKAPhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:37:42 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:58067 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261949AbUKAPRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 10:17:37 -0500
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, xorg@freedesktop.org
In-Reply-To: <Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099170891.1424.1.camel@krustophenia.net>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041030222720.GA22753@hockin.org>
	 <Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 10:17:33 -0500
Message-Id: <1099322253.3647.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 07:49 +0100, Jan Engelhardt wrote:
> Z Smith wrote:
> >Or join me in my effort to limit bloat. Why use an X server
> >that uses 15-30 megs of RAM when you can use FBUI which is 25 kilobytes
> >of code with very minimal kmallocing?
> 
> FBUI does not have 3d acceleration?

Um I don't think chucking X is the answer.  The problem is that it's
embarassingly slow compared to any modern GUI.  If the display were as
snappy as WinXP I don't care if it's 200MB.  On my desktop I constantly
see windows redrawing every freaking widget in situations where XP would
just blit from an offscreen buffer or something.

Anyway please keep replies off LKML and on the Xorg list...

Lee

