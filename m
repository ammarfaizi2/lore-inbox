Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVC3Gok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVC3Gok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVC3Go0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:44:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9629 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261771AbVC3Gnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:43:49 -0500
Date: Tue, 29 Mar 2005 22:41:29 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       johnpol@2ka.mipt.ru, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329224129.09199e8f.pj@engr.sgi.com>
In-Reply-To: <1112161939.20919.96.camel@frecb000711.frec.bull.fr>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112100675.8426.72.camel@frecb000711.frec.bull.fr>
	<20050329073558.797001c1.pj@engr.sgi.com>
	<1112161939.20919.96.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume wrote:
>   I'm sorry but I really don't understand why you're speaking about
> accounting when I present results about fork connector. I agree that
> ELSA is using the fork connector but the fork connector has nothing to
> do with accounting.

True - sorry.  I kinda hijacked your thread.  I had fork_connector
associated in my mind with process accounting, so made the leap from
analyzing the fork_connector mechanism on its own merit, to analyzing
whether it was useful for collecting the new process accounting
information that was needed from forks.

In my own defense, I don't see where the motivations for fork_connector
are spelled out in the presentation to this patch, and it seems that
the other potential uses of it are less well explored at this point.

So I think my leap was a small one ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
