Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUEaHcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUEaHcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 03:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUEaHcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 03:32:32 -0400
Received: from [213.146.154.40] ([213.146.154.40]:60368 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262388AbUEaHcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 03:32:31 -0400
Date: Mon, 31 May 2004 08:32:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>,
       Danny ter Haar <dth@dth.net>, wa1ter@myrealbox.com,
       dth@ncc1701.cistron.net, Netdev <netdev@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Re: Gigabit Kconfig problems with yesterday's update
Message-ID: <20040531073211.GA4894@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	"Randy.Dunlap" <rddunlap@osdl.org>, Danny ter Haar <dth@dth.net>,
	wa1ter@myrealbox.com, dth@ncc1701.cistron.net,
	Netdev <netdev@oss.sgi.com>, Andrew Morton <akpm@osdl.org>
References: <40B8A37D.1090802@myrealbox.com> <20040530134544.GE13111@fs.tum.de> <20040530143734.GA24627@dth.net> <20040530094120.61b22d2e.rddunlap@osdl.org> <40BA1F25.4080402@pobox.com> <20040530193706.GG13111@fs.tum.de> <Pine.LNX.4.58.0405301302020.1632@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405301302020.1632@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 01:06:53PM -0700, Linus Torvalds wrote:
> is it really sane these days to split out gigabit from the "regular" 
> ethernets? gigabit ethernet is getting quite a bit more common than it 
> used to be, and a lot of the gigabit devices are just "standard ethernet" 
> as far as the user is concerned, and in fact they are often _used_ in just 
> regular 10/100Mbps setups.

Or have a gige chip that's crippled to do only 10/100, like the sungem
on my ibook.
