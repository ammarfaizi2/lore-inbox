Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWJEUoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWJEUoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWJEUoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:44:46 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:26087 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932128AbWJEUop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:44:45 -0400
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
From: Lee Revell <rlrevell@joe-job.com>
To: Dominique Dumont <domi.dumont@free.fr>
Cc: Francesco Peeters <Francesco@FamPeeters.com>,
       alsa-user <alsa-user@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87y7rusddc.fsf@gandalf.hd.free.fr>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	 <87y7rusddc.fsf@gandalf.hd.free.fr>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 16:45:10 -0400
Message-Id: <1160081110.2481.104.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 22:42 +0200, Dominique Dumont wrote:
> "Francesco Peeters" <Francesco@FamPeeters.com> writes:
> 
> > Have you tried using a different slot for the SB Live?
> 
> Yes. No change at all. (Sorry for the delay).

This is going to be a problem with the SATA driver not ALSA.  I've heard
that some motherboards do evil stuff like implementing legacy drive
access modes using SMM which would cause dropouts without xruns
reported.

Please report it on LKML.

Lee

