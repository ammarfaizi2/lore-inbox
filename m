Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVEaQSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVEaQSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVEaQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:18:34 -0400
Received: from mxout1.netvision.net.il ([194.90.9.20]:64205 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S261934AbVEaQJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:09:40 -0400
Date: Tue, 31 May 2005 19:42:58 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: problem with ALSA ane intel modem driver
In-reply-to: <200505311222.03463.cijoml@volny.cz>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Mail-followup-to: Michal Semler <cijoml@volny.cz>, linux-kernel@vger.kernel.org
Message-id: <20050531164258.GB12283@sashak.softier.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200505280716.46688.cijoml@volny.cz> <20050531101015.GF9755@tecr>
 <200505311222.03463.cijoml@volny.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:22 Tue 31 May     , Michal Semler wrote:
> > > codec_semaphore: semaphore is not ready [0x1][0x700300]
> > > codec_write 0: semaphore is not ready for register 0x2c
> >
> > And this is something new. What is output of
> > 'cat /proc/asound/card1/codec97#0/mc97#1-1' ?
> 
> notas:/home/cijoml# cat /proc/asound/card1/codec97#0/mc97#1-1
> 1-1/0: Silicon Laboratory Si3036,8 rev 7

Fine, this codec is supported. 

Semaphore warning (both 0x54 and 0x2c) should be fixed in ALSA CVS.

Sasha.

