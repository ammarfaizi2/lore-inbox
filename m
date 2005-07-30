Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVG3J7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVG3J7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 05:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVG3J7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 05:59:35 -0400
Received: from darwin.snarc.org ([81.56.210.228]:22189 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261745AbVG3J6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 05:58:40 -0400
Date: Sat, 30 Jul 2005 11:58:36 +0200
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space (updated)
Message-ID: <20050730095836.GA21671@snarc.org>
References: <20050728145353.GL11644@mellanox.co.il> <Pine.LNX.4.61.0507290929250.26861@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507290929250.26861@yvahk01.tjqt.qr>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
From: tab@snarc.org (Vincent Hanquez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 09:40:14AM +0200, Jan Engelhardt wrote:
> >3i. if/else/do/while/for/switch
> >	space between if/else/do/while and following/preceeding
> >	statements/expressions, if any
> 
> Why this? if(a) {} is not any worse than if (a). I would make this an option.

please no, it's really better to have a unified CodingStyle.
and "if (" is a lot more used than "if(".

$ grep -r "if (" linux-2.6.12/* | wc -l 
288027
$ grep -r "if(" linux-2.6.12/* | wc -l 
20682


-- 
Vincent Hanquez
