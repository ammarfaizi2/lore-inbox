Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUJPWtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUJPWtF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 18:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUJPWtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 18:49:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6866 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268947AbUJPWtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 18:49:03 -0400
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@ucw.cz>, M <mru@mru.ath.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097956343.2148.17.camel@krustophenia.net>
References: <41650CAF.1040901@unimail.com.au>
	 <20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
	 <yw1x7jq2n6k3.fsf@mru.ath.cx>  <20041007143245.GA1698@openzaurus.ucw.cz>
	 <1097956343.2148.17.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097963167.13226.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 16 Oct 2004 22:46:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-16 at 20:52, Lee Revell wrote:
> > What benefits? HZ=1000 takes 1W more on my system.
> Better timer resolution?

And heavily reduced accuracy on a lot of laptops where 1000Hz
is enough to make the clock slide every time the battery state is
queried or an SMM event triggers.

Getting the best of both worlds depends on the stuff discussed at OLS
being finished, then you can have 1Khz accurancy and battery life

