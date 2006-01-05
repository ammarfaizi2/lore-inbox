Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWAEMtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWAEMtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWAEMtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:49:08 -0500
Received: from post.pl ([212.85.96.51]:49607 "HELO v00051.home.net.pl")
	by vger.kernel.org with SMTP id S1750893AbWAEMtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:49:06 -0500
Message-ID: <43BD1576.2050107@post.pl>
Date: Thu, 05 Jan 2006 13:47:50 +0100
From: "Leonard Milcin Jr." <leonard.milcin@post.pl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] ALSA userspace API complexity
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote in his signature:
 > -----------------------------------------------------------
 > *Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
 > -----------------------------------------------------------
 > Allow me translate sentence from my signature to english
 > "People do not have problems they create them themselves"
 > and ALSA case matches in 100%.

Look, kloczek, how less problems we cold have by banishing
all the technology and going back to stone age?

The complexity is sometimes unavoidable if one tries to
please as many as possible. But why not userspace library
that simplifies access to ALSA for those who don't need
all the ,,complexity''? That pleases both -- those who
need feauters, and those who only need to pass something
to speakers. Maybe there are cards that work with OSS and
not with ALSA, and that may be the reason to keep it just
for some time. But in the long run I don't think there is
a need to have two sound systems in kernel just because
one is complicated and other lacks some features.

Leonard
