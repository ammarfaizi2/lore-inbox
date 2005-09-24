Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVIXWy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVIXWy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 18:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVIXWy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 18:54:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:51404 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750774AbVIXWy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 18:54:57 -0400
Subject: Re: [BUG] alsa volume and settings not restored after suspend
From: Lee Revell <rlrevell@joe-job.com>
To: patrizio.bassi@gmail.com
Cc: "Kernel," <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <4335909D.2070904@gmail.com>
References: <4335909D.2070904@gmail.com>
Content-Type: text/plain
Date: Sat, 24 Sep 2005 16:28:16 -0400
Message-Id: <1127593697.18892.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-24 at 19:45 +0200, Patrizio Bassi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> As topic.
> 
> Suspend works perfectly, but after resume, no sound from audio card.

I'm not surprised, suspend/resume is not implemented for that device.

It looks like it would not be too hard, see es1938.c for an example.

Lee

