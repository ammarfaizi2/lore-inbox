Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUE0PMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUE0PMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbUE0PMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:12:47 -0400
Received: from lnscu5.lns.cornell.edu ([128.84.44.111]:17929 "EHLO
	lnscu5.lns.cornell.edu") by vger.kernel.org with ESMTP
	id S264668AbUE0PMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:12:45 -0400
From: Valentin Kuznetsov <vk@mail.lns.cornell.edu>
Organization: Cornell University
To: linux-kernel@vger.kernel.org
Subject: maestro3 is broken in 2.6.5 and 2.6.6
Date: Thu, 27 May 2004 11:10:21 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405271110.21376.vk@mail.lns.cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
when I switched from 2.6.4 kernel to 2.6.5 and 2.6.6 my maestro sound card 
stop working meaning instead of sound I can hear noise. I was using OSS 
matestro3 module.

Here is my profile:
PCI:
02:09.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)

Modules:
maestro3               36232  0
soundcore               9344  1 maestro3
ac97_codec             19040  1 maestro3

Config:
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_MAESTRO3=m
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_MAESTRO3=m

the rest is commented out.

Any clue why it stop working? I'm willing to help testing stuff if necessary.
Thanks,
Valentin.

