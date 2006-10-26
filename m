Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423611AbWJZQhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423611AbWJZQhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423612AbWJZQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:37:13 -0400
Received: from opensubscriber.com ([206.222.18.114]:41103 "EHLO
	mail.opensubscriber.com") by vger.kernel.org with ESMTP
	id S1423613AbWJZQhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:37:11 -0400
Date: Fri, 27 Oct 2006 00:37:11 +0800
Message-ID: <9975050.1161880631044.JavaMail.websites@opensubscriber>
From: saravanan_sprt@hotmail.com
Reply-To: saravanan_sprt@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: UCB1400 driver problem in pxa270
In-Reply-To: <20060707114145.GA5195@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am a newbie in using UCB1400 chip. Iam using Toradex Colibri module PXA270 as my target system with UCB1400 chip integrated.
I have a problem in enabling the audio system using UCB1400. Can anyone point me, how could I enable and use the UCB1400 driver on linux 2.6.12 platform. I have applied Nicolas Pitre patches and configured kernel CONFIG_INPUT, CONFIG_SND, CONFIG_SOUND,CONFIG_SND_PXA2xx_AC97, CONFIG_SND_PXA2xx_PCM to  =y. The kernel builds well, but on boot the UCB1400 driver didn't gets registered and there are no more interrupts enabled in /proc/interrupts with following boot message,
.....
.....
ts: UCB1x00 touchscreen protocol output
Advanced Linux Sound Architecture Driver Version 1.0.9rc2 ( The MAr 24 10:34:34 2005 UTC)
ALSA device list:
  No soundcards found.
....
....

The problem seems to be due to driver_register(pxa2xx-ac97) and bus match.

Any help will be appreciated .

Thanks
Sara


--
This message was sent on behalf of saravanan_sprt@hotmail.com at openSubscriber.com
http://www.opensubscriber.com/message/linux-kernel@vger.kernel.org/4398951.html
