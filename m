Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030977AbWKOUfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030977AbWKOUfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030981AbWKOUfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:35:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:27359 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030977AbWKOUf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:35:29 -0500
Subject: Re: [patch] floppy: suspend/resume fix
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Mikael Pettersson <mikpe@it.uu.se>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061115202418.GC3875@elf.ucw.cz>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se>
	 <20061112212941.GA31624@flint.arm.linux.org.uk>
	 <20061112220318.GA3387@elte.hu>
	 <20061112235410.GB31624@flint.arm.linux.org.uk>
	 <20061114110958.GB2242@elf.ucw.cz> <1163522062.14674.3.camel@mindpipe>
	 <20061115202418.GC3875@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 15:34:58 -0500
Message-Id: <1163622899.14674.174.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 21:24 +0100, Pavel Machek wrote:
> On Tue 2006-11-14 11:34:21, Lee Revell wrote:
> > On Tue, 2006-11-14 at 12:09 +0100, Pavel Machek wrote:
> > > Suspending with mounted floppy is a user error.
> > 
> > Huh?  How so?
> 
> Floppy is removable, and you are expected to umount removable devices
> before suspend.

Ah, OK.  I read that as "it's an error for the user to close the lid
with a floppy or CD in the drive".  But really HAL or the desktop
environment or whatever is supposed to do it...

Lee

