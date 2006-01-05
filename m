Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWAEVSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWAEVSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAEVSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:18:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40379 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932215AbWAEVSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:18:14 -0500
Date: Thu, 5 Jan 2006 22:14:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Olivier Galibert <galibert@pobox.com>, Jaroslav Kysela <perex@suse.cz>,
       zwane@commfireservices.com,
       ALSA development <alsa-devel@alsa-project.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, sailer@ife.ee.ethz.ch,
       kyle@parisc-linux.org, James@superbug.demon.co.uk,
       Thorsten Knabe <linux@thorsten-knabe.de>, linux-sound@vger.kernel.org,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       jgarzik@pobox.com, zab@zabbo.net, parisc-linux@lists.parisc-linux.org,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [parisc-linux] Re: [OT] ALSA userspace API complexity
In-Reply-To: <1136472979.16358.33.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0601052211100.24519@yvahk01.tjqt.qr>
References: <20050726150837.GT3160@stusta.de>  <20060103193736.GG3831@stusta.de>
  <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> 
 <mailman.1136368805.14661.linux-kernel2news@redhat.com> 
 <20060104030034.6b780485.zaitcev@redhat.com>  <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
  <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> 
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> 
 <20060105142120.GA28611@dspnet.fr.eu.org> <1136472979.16358.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> historical and political reasons, not technical ones.  When
>> performance raises its ugly head and you end up having to listen to
>> engineers again you end up with DRI and that:
>> 
>> Module                  Size  Used by
>> nvidia               3464380  12 
>
>That isn't DRI. DRI is a good deal smaller than the crazy nvidia stuff.
>
>radeon                 81089  1
>drm                    83433  2 radeon
>
>.. speaks volumes doesn't it 8)

What nvidia version number is that? I remember it being over 5 megs in size. Oh
BTW, that's one GOOD REASON for me to believe having certain parts in userspace
(e.g. X was mentioned) being a good thing - after all, you can't swap kernel
memory. If nvidia continued like that, their kernel module would eventually
exceed the amount of RAM that is apparently installed.

>> X is a beautiful example of how things should not have been done.  Its
>> only redeeming quality is that it exists and works, and that's
>> definitively a non-negligible one.
>
>X servers have been implemented a variety of ways involving mixed user
>and kernel space environments, user space only, pure kernel space, and
>even downloading the server onto a graphics coprocessor and talking X
>protocol to it.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
