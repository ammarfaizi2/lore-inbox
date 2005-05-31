Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVEaKoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVEaKoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVEaKoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:44:17 -0400
Received: from relay.felk.cvut.cz ([147.32.80.7]:64017 "EHLO
	relay.felk.cvut.cz") by vger.kernel.org with ESMTP id S261758AbVEaKoL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:44:11 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: problem with ALSA ane intel modem driver
Date: Tue, 31 May 2005 12:22:02 +0200
User-Agent: KMail/1.7.2
References: <200505280716.46688.cijoml@volny.cz> <20050531101015.GF9755@tecr>
In-Reply-To: <20050531101015.GF9755@tecr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200505311222.03463.cijoml@volny.cz>
X-MailScanner-felk: Found to be clean
X-MailScanner-SpamCheck-felk: not spam, SpamAssassin (score=-4.9, required 5,
	BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne út 31. kvìtna 2005 12:10 Sasha Khapyorsky napsal(a):
> On 07:16 Sat 28 May     , Michal Semler wrote:
> > for testing purposes I compiled 2.6.12-rc5 and my dmesg si full of
> >
> > codec_semaphore: semaphore is not ready [0x1][0x701300]
> > codec_read 1: semaphore is not ready for register 0x54
> > codec_semaphore: semaphore is not ready [0x1][0x701300]
> > codec_write 1: semaphore is not ready for register 0x54
>
> This one (register 0x54) should be fixed in ALSA CVS.
>
> > codec_semaphore: semaphore is not ready [0x1][0x700300]
> > codec_write 0: semaphore is not ready for register 0x2c
>
> And this is something new. What is output of
> 'cat /proc/asound/card1/codec97#0/mc97#1-1' ?

notas:/home/cijoml# cat /proc/asound/card1/codec97#0/mc97#1-1
1-1/0: Silicon Laboratory Si3036,8 rev 7

Extended modem ID: codec=1 LIN1
Modem status     : PRB(res) PRE(ADC2) PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 12000Hz


>
> Sasha.

-- 
S pozdravem

Michal Semler
