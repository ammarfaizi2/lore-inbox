Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVEaJwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVEaJwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVEaJwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:52:19 -0400
Received: from sa8.bezeqint.net ([192.115.104.22]:29677 "EHLO sa8.bezeqint.net")
	by vger.kernel.org with ESMTP id S261560AbVEaJwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:52:16 -0400
Date: Tue, 31 May 2005 13:10:15 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with ALSA ane intel modem driver
Message-ID: <20050531101015.GF9755@tecr>
Mail-Followup-To: Michal Semler <cijoml@volny.cz>,
	linux-kernel@vger.kernel.org
References: <200505280716.46688.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505280716.46688.cijoml@volny.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07:16 Sat 28 May     , Michal Semler wrote:
> 
> for testing purposes I compiled 2.6.12-rc5 and my dmesg si full of 
> 
> codec_semaphore: semaphore is not ready [0x1][0x701300]
> codec_read 1: semaphore is not ready for register 0x54
> codec_semaphore: semaphore is not ready [0x1][0x701300]
> codec_write 1: semaphore is not ready for register 0x54

This one (register 0x54) should be fixed in ALSA CVS.

> codec_semaphore: semaphore is not ready [0x1][0x700300]
> codec_write 0: semaphore is not ready for register 0x2c

And this is something new. What is output of
'cat /proc/asound/card1/codec97#0/mc97#1-1' ?

Sasha.
