Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTKKPJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTKKPJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:09:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:60175 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S263526AbTKKPJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:09:20 -0500
Date: Tue, 11 Nov 2003 16:09:15 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031111150915.GA13734@alpha.home.local>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Mon, Nov 10, 2003 at 05:28:14PM -0200, Marcelo Tosatti wrote:
> Here goes -rc1.
> 
> It contains network driver fixes (b44, tg3, 8139cp), several x86-64
> bugfixes, amongst others.

Interestingly, tg3, which had a slight tendency to hang on 2.4.22 when duplex
mismatched seems rock solid now. I could even force renegociation and duplex
mismatches during heavy loads (pktgen) without even a warning in the logs.

No pb so far on a test server (DL320 P4/CSB6 IDE/TG3). Good work !

Cheers,
Willy

