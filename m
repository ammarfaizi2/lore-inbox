Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933116AbWKMW7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbWKMW7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933131AbWKMW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:59:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:11159 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S933116AbWKMW7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:59:48 -0500
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061113221611.GG4824@voodoo.jdc.home>
References: <1163374762.5178.285.camel@gullible>
	 <1163404727.15249.99.camel@laptopd505.fenrus.org>
	 <1163443887.5313.27.camel@mindpipe>
	 <1163449139.15249.197.camel@laptopd505.fenrus.org>
	 <20061113221611.GG4824@voodoo.jdc.home>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 17:59:08 -0500
Message-Id: <1163458748.5313.74.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 17:16 -0500, Jim Crilly wrote:
> I know that Debian ships both because I have to switch back to the OSS
> driver whenever I want to play one of those closed source games that
> mmap /dev/dsp because the ALSA OSS emulation can't seem to handle
> having the device opened via ALSA and /dev/dsp at the same time and
> the aoss wrapper doesn't work for apps that use mmap on /dev/dsp.
> 

This should work with the ALSA /dev/dsp emulation, if you kill all other
sound using apps before launching the game (which the OSS driver also
requires).

Lee

