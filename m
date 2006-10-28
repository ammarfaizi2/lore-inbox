Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWJ1GAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWJ1GAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 02:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWJ1GAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 02:00:09 -0400
Received: from main.gmane.org ([80.91.229.2]:17301 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751850AbWJ1GAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 02:00:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Shai Peretz <shai@consonet.com>
Subject: Re: 2.6.18: =?utf-8?b?aGRhX2ludGVsOg==?= =?utf-8?b?YXp4X2dldF9yZXNwb25zZQ==?= timeout, switching to =?utf-8?b?c2luZ2xlX2NtZA==?= mode...
Date: Sat, 28 Oct 2006 05:07:37 +0000 (UTC)
Message-ID: <loom.20061028T070443-243@post.gmane.org>
References: <451834D0.40304@goop.org> <s5hlko7szjy.wl%tiwai@suse.de> <451F5A1C.2060201@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.132.80.98 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1) Gecko/20060601 Firefox/2.0 (Ubuntu-edgy))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy <at> goop.org> writes:

> 
> Takashi Iwai wrote:
> > You must see difference with mm1 (suppose that mm1 already includes
> > the latest ALSA patches).  When the CORB/RIRB interrupt gets broken,
> > the driver first switches to poling mode, then single_cmd mode as
> > fallback.
> >   
> 
> I tried -mm2, and I'm seeing the same problem.
> 
> > Also, try disable_msi=1 option for mm1.  MSI seems broken on some
> > systems.
> >   
> 
> This made no difference.
> 
>     J
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> 

Hi,

I am trying to fight the same issue for few weeks now, with no progress.
under windows sound works fine, so seems like no hardware issue.
under ubuntu 6.10, with latest alsa drivers, I get the message above.
seems like the kernel only see the modem part of the sound card, and not the
other part.
on my system, I can't disable/enable the modem in the bios, only the whole sound
card.

Any idea what to look for next?

Thanks, Shai.

