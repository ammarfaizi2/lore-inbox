Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbTLCEA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 23:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTLCEA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 23:00:29 -0500
Received: from holomorphy.com ([199.26.172.102]:15821 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264492AbTLCEA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 23:00:28 -0500
Date: Tue, 2 Dec 2003 20:00:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Xose Vazquez Perez <xose@wanadoo.es>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ATI boards [was Re: Linux 2.4 future]
Message-ID: <20031203040022.GS8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Xose Vazquez Perez <xose@wanadoo.es>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3FCD5533.8050105@wanadoo.es> <Pine.LNX.4.58.0312021939400.2072@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312021939400.2072@home.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Xose Vazquez Perez wrote:
>> Torvalds was talking about R200 chip. Those boards are 8500, and
>> 9100/8500 LE. IMO they are the best for FOSS.

On Tue, Dec 02, 2003 at 07:42:08PM -0800, Linus Torvalds wrote:
> Actually, the whole R2x0 family seems to be largely supported by the DRI
> drivers.
> The newer cards just need a recent enough DRI server to know about them,
> but they should otherwise be ok.
> It's the R300-based cards (ATI 9800 & friends) that apparently don't get
> any open-source 3D acceleration right now.
> (But hey, I may be wrong - I follow the DRI stuff only sporadically).

The graphics drivers do a lot of memory mapping, and so I need to fish
around down there for various things I'm hacking on. How much kernel
content to this would you say there is out-of-tree?


-- wli
