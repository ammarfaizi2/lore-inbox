Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWAEXt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWAEXt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbWAEXt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:49:56 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:63493 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751428AbWAEXty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:49:54 -0500
Date: Fri, 6 Jan 2006 00:49:51 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060105234951.GA10167@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Joern Nettingsmeier <nettings@folkwang-hochschule.de>,
	Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
	Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	ALSA development <alsa-devel@alsa-project.org>,
	James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
	linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
	parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
	Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, LKML <linux-kernel@vger.kernel.org>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <43BDA02F.5070103@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BDA02F.5070103@folkwang-hochschule.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:39:43PM +0100, Joern Nettingsmeier wrote:
> modem dialup users know better than to chime in to networking core 
> discussions and complain they don't need all that complexity. why do 
> professional audio users always have to put up with people who only 
> listen to mp3s whining about a complicate API?

Funnily enough, people who added SIGIO and epoll did not remove
select nor limited its capabilities.

The ALSA api has issues, whether you want to acknowledge them or not.
The OSS api has issues too, of course.  But it is there to stay, and
it has advantages in some situations, like when simplicity or not
depending on a shared library matters.  Ignoring it is stupid.  Doing
your best to cripple it is stupid.  The OSS api is an entrypoint in
the sound system as valid and important than others.

  OG.

