Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWJFOAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWJFOAa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbWJFOAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:00:30 -0400
Received: from gate.perex.cz ([85.132.177.35]:35549 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1422672AbWJFOA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:00:29 -0400
Date: Fri, 6 Oct 2006 16:00:27 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Takashi Iwai <tiwai@suse.de>
Subject: sysfs & ALSA card
Message-ID: <Pine.LNX.4.61.0610061548340.8573@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I would like to discuss where is the right root for soundcards in 
the sysfs tree. I would like to put card specific variables like id there 
(see /proc/asound/card0/id). Also, I plan to create link from 
/sys/class/sound tree to the appropriate card to show relationship. 
Something like:

/sys/<somewhere>/soundcard/0

/sys/class/sound/controlC0/soundcard -> ../../../<somewhere>/soundcard/0

	Any comments and suggestions?

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
