Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbWADRdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbWADRdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbWADRdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:33:11 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:18346 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S965235AbWADRdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:33:08 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Wed, 4 Jan 2006 17:31:18 +0000
User-Agent: KMail/1.9
Cc: Andi Kleen <ak@suse.de>,
       Joern Nettingsmeier <nettings@folkwang-hochschule.de>,
       Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <20060104123538.GE7222@wotan.suse.de> <Pine.LNX.4.61.0601041337340.9321@tm8103.perex-int.cz>
In-Reply-To: <Pine.LNX.4.61.0601041337340.9321@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041731.18344.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 12:41, Jaroslav Kysela wrote:
> On Wed, 4 Jan 2006, Andi Kleen wrote:
> > > this is like whining about the oh so complex networking infrastructure
> > > and iptables and constantly reminiscing how simple it used to be to set
> > > up a modem on /dev/ttyS0.
> >
> > Can be nearly all CONFIGured out. With the removal of the sane
> > sound drivers that would be impossible though.
>
> The code reduction is possible also for the ALSA midlevel code.
> For example, removing the verbose /proc support might save some bytes and
> so on.

But can more be done? Andi's not pointed anything out in particular (unless I 
am mistaken), but could more of ALSA be configurable, even if it is at the 
expense of userspace API features?

As has already been pointed out, individual ALSA drivers with comparable 
features tend themselves to be smaller than the original OSS ones. It's the 
ALSA infrastructure that comes at a cost, and surely not all if it is 
mandatory.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
