Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWJCNav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWJCNav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 09:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWJCNav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 09:30:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25218 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750809AbWJCNau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 09:30:50 -0400
Subject: Re: PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved with
	2.6.18 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Wink Saville <wink@saville.com>
Cc: Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4521E326.2000406@saville.com>
References: <45206777.7020405@saville.com> <1159808447.4652.6.camel@mhcln03>
	 <4521E326.2000406@saville.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 03 Oct 2006 15:30:25 +0200
Message-Id: <1159882225.2891.525.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 21:12 -0700, Wink Saville wrote:
> Matthias,
> 
> Thanks, I tried your config file on 2.6.18 and it works!
> 
> The first time I tried my command line was:
> 
> Command line: root=/dev/sda2 ro quiet splash initcall_debug 
> console=ttyS0,115200n8 loglevel=7 video=nvidiafb:nomtrr
> 
> and it came up but no keyboard or mouse, I changed it too:
> 
> Command line: root=/dev/sda2 ro quiet splash
> 
> You mentioned you "saw some hangs", I assume with the current 
> configuration your having no problems with stability?


please please remove "quiet"... that removes any kind of useful debug
output! It also makes you point at the wrong party for blaming hangs
on ;)


