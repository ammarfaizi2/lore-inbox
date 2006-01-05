Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752153AbWAELlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbWAELlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbWAELlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:41:05 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:43537 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1752151AbWAELlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:41:03 -0500
Date: Thu, 5 Jan 2006 12:41:01 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       kloczek@rudy.mif.pg.gda.pl, Adrian Bunk <bunk@stusta.de>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060105114101.GA43299@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
	kloczek@rudy.mif.pg.gda.pl, Adrian Bunk <bunk@stusta.de>,
	Tomasz Torcz <zdzichu@irc.pl>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
	sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
	kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
	jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <200601041423.43206.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601041423.43206.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 02:23:42PM +0000, Alistair John Strachan wrote:
> Or, take an ioctl approach (which people here seem to love; urgh):

I'm afraid you missed the point there.  ioctl or not ioctl is not
important, and yes, ioctls have a lot of problems.  The problem is
having a library define the public interface for kernel services.  I
don't see how come Linus accepted that, unless he doesn't really use
sound and just doesn't care, which is my current interpretation.

  OG.

