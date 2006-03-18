Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWCRA0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWCRA0H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWCRA0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:26:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50853 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932253AbWCRA0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:26:04 -0500
Subject: Re: [PATCH 08/21] Cx88 default picture controls values
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Marcin Rudowski <mar_rud@poczta.onet.pl>,
       Ian Pickworth <ian@pickworth.me.uk>
In-Reply-To: <1142629814.25258.96.camel@mindpipe>
References: <20060317205359.PS65198900000@infradead.org>
	 <20060317205434.PS87790000008@infradead.org>
	 <1142629814.25258.96.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 17 Mar 2006 21:25:48 -0300
Message-Id: <1142641548.4630.31.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sex, 2006-03-17 às 16:10 -0500, Lee Revell escreveu:
> On Fri, 2006-03-17 at 17:54 -0300, mchehab@infradead.org wrote:
> >  - volume set to 0dB (now is -32dB)
> 
> Shouldn't volumes default to muted so as not to damage people's speakers
> and/or hearing?
Good point. Generally, video devices starts with an open volume when the
user opens the video application. After closed, it turns off audio. In
fact, for most applications, this is really not important, since default
is also stored at the application itself. If we compare with a TV set,
when people turn TV on, they expect to listen something.

About cx88, in the past, we were starting with a low volume, but people
complained that this is bad, since they don't know for sure if the audio
is working fine.

If we decide to change to start without volume, we will need to patch
all other devices, since current V4L default is to start at maximum
volume (except for msp3400, that starts at about 90% of max scale, due
troubles with maximum volume on some boards).

> 
> Lee
> 
Cheers, 
Mauro.

