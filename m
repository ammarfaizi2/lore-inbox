Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUGFXZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUGFXZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUGFXZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:25:40 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:17894 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264734AbUGFXZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:25:39 -0400
Date: Wed, 7 Jul 2004 01:25:38 +0200
From: bert hubert <ahu@ds9a.nl>
To: Redeeman <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040706232538.GA8054@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Redeeman <lkml@metanurb.dk>,
	LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org> <20040629222751.392f0a82.davem@redhat.com> <20040630152750.2d01ca51@dell_ss3.pdx.osdl.net> <20040630153049.3ca25b76.davem@redhat.com> <20040701133738.301b9e46@dell_ss3.pdx.osdl.net> <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net> <1089155965.15544.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089155965.15544.9.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 01:19:25AM +0200, Redeeman wrote:

> so this should fix the issues? can you also tell me why this suddenly happend? that would make me a real happy man

It appears older linux kernels would announce window scaling capability, but
not in fact scale their windows themselves, thus hiding the problem.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
