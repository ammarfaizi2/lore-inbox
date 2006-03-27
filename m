Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWC0VSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWC0VSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWC0VR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:17:59 -0500
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:21220 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751453AbWC0VR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:17:58 -0500
Date: Mon, 27 Mar 2006 13:17:54 -0800
To: Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 32bit compat for rtnetlink wireless extensions?
Message-ID: <20060327211754.GB31813@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200603261408.48766.arnd@arndb.de> <20060327184242.GC31478@bougret.hpl.hp.com> <200603272310.44692.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603272310.44692.arnd@arndb.de>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 11:10:44PM +0200, Arnd Bergmann wrote:
> Am Monday 27 March 2006 20:42 schrieb Jean Tourrilhes:
> >         Actually, when things are passed over RtNetlink, the pointer
> > is removed, and the content of IW_HEADER_TYPE_POINT is moved to not
> > leave a gap.
> 
> Ah, that makes sense, thanks for the explanation.
> 
> So if the wireless ioctl interface ever got retired, that code could
> get simplified a lot to just pass around a flat data structure, right?
> 
> 	Arnd <><

	Actually, it could be removed *now*. You would just have to
fix all wireless drivers in existence. I will scratch my head to see
if we could plan a smooth transition.

	Jean
