Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWIKUUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWIKUUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 16:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWIKUUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 16:20:02 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:5056 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965040AbWIKUUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 16:20:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Takashi Iwai <tiwai@suse.de>
Subject: 2.6.18-rc6-mm1: endless loop in snd_hda_intel on HPC 6325, sometimes
Date: Mon, 11 Sep 2006 22:20:04 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609112220.04753.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On the HPC 6325 I'm currently using snd_hda_intel sometimes goes into an
endless loop in wich it plays the same chunk of sound (< 1 sec.) repeatedly
forever.

It helps to reload the snd_hda_intel module.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
