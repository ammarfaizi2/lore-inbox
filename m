Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVHIRyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVHIRyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVHIRyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:54:53 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21448 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932562AbVHIRyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:54:52 -0400
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal (version
	2)
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, NAGANO Daisuke <breeze.nagano@nifty.ne.jp>,
       alan@lxorguk.ukuu.org.uk, sailer@ife.ee.ethz.ch,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zaitcev@yahoo.com,
       Christoph Eckert <ce@christeck.de>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20050809174906.GA4006@stusta.de>
References: <20050729153226.GE3563@stusta.de>
	 <1123607633.5601.7.camel@mindpipe>  <20050809174906.GA4006@stusta.de>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 13:54:48 -0400
Message-Id: <1123610089.8210.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 19:49 +0200, Adrian Bunk wrote:
> I'd deprecate them without moving them.
> 

OK, I think that will still be slightly confusing becuase it comes
before Sound in the kernel config, but maybe the deprecated part will
make people think twice.

I think we should at least label these clearly as part of OSS.  Users at
least seem to know that mixing OSS and ALSA modules is bad.

> I'll send a patch unless someone tells that any functionality of these
> drivers is lacking in ALSA. 

OK.  I'm almost positive there is no functionality missing, there have
not been any reports of people needing to use the OSS driver on any of
the ALSA lists.

Lee 

