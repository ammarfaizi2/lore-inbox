Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTLID5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTLID5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:57:14 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:43653 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S262740AbTLID5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:57:12 -0500
Message-ID: <3FD54817.9050402@hanaden.com>
Date: Mon, 08 Dec 2003 21:57:11 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031204 Thunderbird/0.4RC1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux - LIST <linux-kernel@vger.kernel.org>
Subject: VT82C686  - no sound 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alsaconf is reporting it cannot be configured.... when the below modules 
are manually loaded, esd finds the /dev/dsp and runs but there is no 
sound.  Sound worked fine on 2.4.23

Any help would be appreciated. thank you

00:04.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
AC97 Audio Controller (rev 21)

Running debian sarge with kernel 2.6 test11

== /etc/modules ==
snd_via82xx
snd_ac97_codec
snd_pcm_oss
snd_page_alloc
snd_pcm
snd_timer
snd_mixer_oss
snd_pcm_oss
snd_mpu401_uart
