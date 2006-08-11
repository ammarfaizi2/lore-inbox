Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWHKIcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWHKIcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWHKIcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:32:42 -0400
Received: from ns.firmix.at ([62.141.48.66]:31959 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750827AbWHKIck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:32:40 -0400
Subject: Re: [PATCH 2/9] sector_t format string
From: Bernd Petrovitsch <bernd@firmix.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jeff Mahoney <jeffm@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608110757090.21588@yvahk01.tjqt.qr>
References: <1155172843.3161.81.camel@localhost.localdomain>
	 <20060809234019.c8a730e3.akpm@osdl.org>
	 <20060810191747.GL20581@ca-server1.us.oracle.com>
	 <20060810194440.GA6845@martell.zuzino.mipt.ru> <44DB945F.5080102@suse.com>
	 <Pine.LNX.4.61.0608110757090.21588@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 11 Aug 2006 10:31:47 +0200
Message-Id: <1155285107.12126.0.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.375 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 07:57 +0200, Jan Engelhardt wrote:
> >> Will
> >> 
> >> 	printk("%S", sector_t);
> >> 
> >> kill at least one kitten?
> >
> >I like the general idea. I think that having to cast every time you want
> >to print a sector number is pretty gross. I had something more like %Su
> >in mind, though.
> 
> What will happen if you run out of %[a-z] ?

My keyboard can produce a lot more characters (even if I ignore the
non-ASCII ones).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

