Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWFTIlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWFTIlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWFTIlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:41:47 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:47078 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S965052AbWFTIlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:41:46 -0400
Date: Tue, 20 Jun 2006 10:41:45 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Chris Rankin <rankincj@yahoo.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17: PM-Timer bug warning?
Message-ID: <20060620084145.GA29378@rhlx01.fht-esslingen.de>
References: <cone.1150766585.735266.688.501@kolivas.org> <20060620075947.33014.qmail@web52914.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620075947.33014.qmail@web52914.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 20, 2006 at 08:59:47AM +0100, Chris Rankin wrote:
> --- Con Kolivas <kernel@kolivas.org> wrote:
> > We don't have such a list that tells us which hardware is prone otherwise we 
> > could have put the workaround for broken chipsets only.
> 
> True, but if there were no way to test for this bug then arguably the bug could not be said to
> exist in the first place. So how would I determine whether my chipset really is prone or not?

OGAWA Hirofumi initially posted a test app:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114297656924494&w=2

and there were lots of PM-Timer abandon triple-read optimization
LKML discussions quite recently where one can read on that topic...

Thanks for your testing help, it's very important!

Andreas Mohr
