Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWG3TrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWG3TrI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWG3TrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:47:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4564 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932450AbWG3TrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:47:06 -0400
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
From: Arjan van de Ven <arjan@infradead.org>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
In-Reply-To: <20060730160738.GB13377@irc.pl>
References: <20060730120844.GA18293@outpost.ds9a.nl>
	 <20060730160738.GB13377@irc.pl>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 30 Jul 2006 21:46:51 +0200
Message-Id: <1154288811.2941.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 18:07 +0200, Tomasz Torcz wrote:
> On Sun, Jul 30, 2006 at 02:08:44PM +0200, bert hubert wrote:
> > Hi everybody,
> > 
> > Since 2.6.18-rc1, up to and including -rc3, cpufreq has died on me. It
> > worked fine in 2.6.16.9.
> > 
> > # modprobe p4_clockmod
> > FATAL: Error inserting p4_clockmod
> > (/lib/modules/2.6.18-rc3/kernel/arch/i386/kernel/cpu/cpufreq/p4-clockmod.ko):
> > Device or resource busy
> > 

as a side note ... you realize that clockmod doesn't actually save you
any power right? ;)


