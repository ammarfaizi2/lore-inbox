Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTIWQL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTIWQLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:11:25 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:4358 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S261492AbTIWQLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:11:24 -0400
Date: Tue, 23 Sep 2003 18:09:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jan Evert van Grootheest <j.grootheest@euronext.nl>,
       Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923160941.GB4161@alpha.home.local>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl> <20030923154137.GA1265@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923154137.GA1265@velociraptor.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 05:41:37PM +0200, Andrea Arcangeli wrote:
 
> note the 64k are only wasted when you use the feature, there's nothing
> wasted if you don't use it.

There's 48k wasted compared to the default 16k, because Jan will not have the
choice of not allocating them with your current patch. And I'm not sure he'll
be happy to follow your advice, to tap into the source file to get them back :-)

Willy

