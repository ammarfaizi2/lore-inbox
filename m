Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263658AbUD2ICY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbUD2ICY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUD2ICX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:02:23 -0400
Received: from levante.wiggy.net ([195.85.225.139]:32939 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S263658AbUD2ICV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:02:21 -0400
Date: Thu, 29 Apr 2004 10:02:19 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429080219.GF4437@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org> <20040429022944.GA24000@buici.com> <20040428193541.1e2cf489.akpm@osdl.org> <20040429031059.GA26060@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429031059.GA26060@buici.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Marc Singer wrote:
> I'm thinking that the problem is that the page cache is greedier that
> most people expect.  For example, if I could hold the page cache to be
> under a specific size, then I could do some performance measurements.

It is actually greedy enough that when my nightly cron starts I suddenly
see apache and pdns_recursor being killed consistently every day. 

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

