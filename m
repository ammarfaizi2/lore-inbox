Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbTIWQ0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTIWQ0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:26:52 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64384
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261738AbTIWQ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:26:50 -0400
Date: Tue, 23 Sep 2003 18:26:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jan Evert van Grootheest <j.grootheest@euronext.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923162646.GB1269@velociraptor.random>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl> <20030923154137.GA1265@velociraptor.random> <20030923160941.GB4161@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923160941.GB4161@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 06:09:41PM +0200, Willy Tarreau wrote:
> On Tue, Sep 23, 2003 at 05:41:37PM +0200, Andrea Arcangeli wrote:
>  
> > note the 64k are only wasted when you use the feature, there's nothing
> > wasted if you don't use it.
> 
> There's 48k wasted compared to the default 16k, because Jan will not have the

48k wasted where? What arch, I thought you meant the original log_buf
memory is not released, I will fix that, then the waste will be zero and
there will be no advantage in having it at compile time anymore, only
disavantages.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
