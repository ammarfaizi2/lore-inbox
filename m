Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVC2WED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVC2WED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVC2WED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:04:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59352 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261520AbVC2WDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:03:46 -0500
Date: Tue, 29 Mar 2005 14:01:06 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: johnpol@2ka.mipt.ru, guillaume.thouvenin@bull.net, akpm@osdl.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329140106.2a9b8aa5.pj@engr.sgi.com>
In-Reply-To: <4249C418.5040007@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112079856.5243.24.camel@uganda>
	<20050329004915.27cd0edf.pj@engr.sgi.com>
	<1112092197.5243.80.camel@uganda>
	<20050329090304.23fbb340.pj@engr.sgi.com>
	<4249C418.5040007@engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay wrote:
> The fork_connector is not designed to solve accounting data collection
> problem.

I don't think I ever said it was designed for that purpose.

Indeed, I will confess to not yet knowing the 'real' purpose of its
design.


> It was never the fork_connector's
> intention to piggy back the data to the accounting file.

I am sure that was not its intention, and I can't imagine I would ever
have said it was.


> CSA needs a similar hook off do_exit() to
> collect more accounting data and write to disk in different
> accounting records format.

Aha - as I suspected - there will be more data to collect, in addition
to both the classic bsd accounting records at exit, and the <parent pid,
child pid> at fork.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
