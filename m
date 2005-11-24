Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbVKXFkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbVKXFkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbVKXFkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:40:05 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:2661 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1030608AbVKXFkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:40:02 -0500
Date: Thu, 24 Nov 2005 06:40:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: davem@davemloft.net, kaber@trash.net, bunk@stusta.de, evil@g-house.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [2.6 patch] do not select NET_CLS
Message-ID: <20051124054001.GB7618@mars.ravnborg.org>
References: <4381F2D2.5000605@trash.net> <20051122.143713.101129339.davem@davemloft.net> <20051122224914.GA17575@mars.ravnborg.org> <20051122.150041.90521592.davem@davemloft.net> <20051123055735.GC7579@mars.ravnborg.org> <20051123181332.0f86bfdb.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123181332.0f86bfdb.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 06:13:32PM -0800, Randy.Dunlap wrote:
> 
> So -q means "quick" ?
>From make help:
-q, --question Run no commands; exit status says if up to date

> I wouldn't mind seeing a -quiet (even less quiet than V=0),
> not even printing the CC, AS, LD, etc. commands -- just let the
> tools print errors & warnings.  I always redirect output to a
> disk file and filter it for errors and warnings anyway, so I
> want hold my breath for this, but ISTM that V=0 could be even
> quieter than it is right now.

make -s shuld give you this. I've not used it for long though...

	Sam
