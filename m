Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269678AbUICNEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269678AbUICNEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbUICNEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:04:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33921
	"EHLO x30.random") by vger.kernel.org with ESMTP id S269674AbUICNEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:04:48 -0400
Date: Fri, 3 Sep 2004 15:03:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: EXT3: problem with copy_from_user inside a transaction
Message-ID: <20040903130309.GD8557@x30.random>
References: <20040903150521.B1834@castle.nmd.msu.ru> <20040903123541.GB8557@x30.random> <1094213179.16078.19.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094213179.16078.19.camel@watt.suse.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 08:06:20AM -0400, Chris Mason wrote:
> prepare_write could reserve blocks, which brings us half way to a
> generic delayed allocation layer.  [..]

sounds good to me!
