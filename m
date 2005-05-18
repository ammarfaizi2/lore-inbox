Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVEROit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVEROit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVEROid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:38:33 -0400
Received: from [85.8.12.41] ([85.8.12.41]:25002 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262234AbVEROiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:38:07 -0400
Message-ID: <428B5349.5090207@drzeus.cx>
Date: Wed, 18 May 2005 16:38:01 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Valdis.Kletnieks@vt.edu, Karel Kulhavy <clock@twibright.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa
References: <20050517095613.GA9947@kestrel>	<200505171208.04052.jan@spitalnik.net>	<20050517141307.GA7759@kestrel>	<1116354762.31830.12.camel@mindpipe>	<20050517192412.GA19431@kestrel.twibright.com>	<200505172027.j4HKRjTV029545@turing-police.cc.vt.edu> <s5hll6csl0b.wl@alsa2.suse.de>
In-Reply-To: <s5hll6csl0b.wl@alsa2.suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> 
> esd is working fine together with dmix.  You should try the latest
> versions (of esd and alsa-lib).  The old version of esd might have a
> bug.
> 

I'd beg to differ. I have to apply the patch made by you to avoid
getting a lot of distortions with esound and dmix:

http://bugzilla.gnome.org/show_bug.cgi?id=140803

Checking in the cvs, this still hasn't been commited.

Rgds
Pierre
