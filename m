Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbVHPRx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVHPRx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVHPRx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:53:27 -0400
Received: from god.demon.nl ([83.160.164.11]:51473 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S1030263AbVHPRx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:53:26 -0400
Date: Tue, 16 Aug 2005 19:53:22 +0200
From: Henk <Henk.Vergonet@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input-driver-yealink-P1K-usb-phone
Message-ID: <20050816175322.GA3240@god.dyndns.org>
References: <20050816142144.GA2939@god.dyndns.org> <1124206681.25596.20.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124206681.25596.20.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 11:38:00AM -0400, Lee Revell wrote:
> On Tue, 2005-08-16 at 16:21 +0200, Henk wrote:
> >   - audio playback    via generic usb audio diver
> >   - audio record      via generic usb audio diver 
> 
> There is no such thing.
> 
> Do you mean the obsolete OSS usb-audio driver, or snd-usb-audio?
> 
> Lee
>

Ehm, I did not know there was still an OSS usb driver.

I have:

Module                  Size  Used by
snd_usb_audio          71936  1
snd_usb_lib            13568  1 snd_usb_audio
snd_rawmidi            20448  1 snd_usb_lib
snd_hwdep               7008  1 snd_usb_audio
yealink                11072  0

and playback is working fine on 2.6.13-rc6.

Today we create the legacy of tomorrow ;).

Henk

