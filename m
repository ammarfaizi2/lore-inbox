Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTFXULE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTFXULE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:11:04 -0400
Received: from relay.pair.com ([209.68.1.20]:9222 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262312AbTFXULB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:11:01 -0400
X-pair-Authenticated: 68.40.145.213
Subject: Re: 2.4.21-ck3
From: Daniel Gryniewicz <dang@fprintf.net>
To: Toplica =?iso-8859-2?Q?Tanaskovi=E6?= <toptan@sezampro.yu>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
In-Reply-To: <200306242144.45511.toptan@sezampro.yu>
References: <200306231418.12060.kernel@kolivas.org>
	 <200306242144.45511.toptan@sezampro.yu>
Content-Type: text/plain; charset=iso-8859-2
Organization: 
Message-Id: <1056486309.1576.4.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 24 Jun 2003 16:25:09 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a data point:
ck3 and alsa 0.9.2 work great here (gentoo system).  All my problems
with post .20-ck4 are resolved.

Daniel

On Tue, 2003-06-24 at 15:44, Toplica Tanaskoviæ wrote:
> Dana ponedeljak 23 jun 2003 06:17, Con Kolivas je napisao/la:
> > Updated patchset.
> >
> > http://kernel.kolivas.org
> 
> 	System sometime freezes for about 2-3 second, and alsa 0.9.4 refuses to work 
> correctly.
> 
> toptan@azdaha:~> aplay /usr/share/sounds/alsa/test.wav
> Playing WAVE '/usr/share/sounds/alsa/test.wav' : Signed 16 bit Little Endian, 
> Rate 44100 Hz, Stereo
> aplay: pcm_write:1025: write error: Input/output error
> 
> 	Well it plays, but only first 500msec, and repeats it about ten times.
> 
> 	Same thing with alsa was happening with 2.5.54-59, so I think its scheduler 
> problem.
> 
> 	ck1 worked fine.
> 
> Distro is SuSE 8.2
> Config & lspci -vvvv are attached.
-- 
Daniel Gryniewicz <dang@fprintf.net>

