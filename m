Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVC2Ots@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVC2Ots (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 09:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVC2Ots
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 09:49:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33200 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262304AbVC2Otq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 09:49:46 -0500
Date: Tue, 29 Mar 2005 06:47:05 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       johnpol@2ka.mipt.ru, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net,
       dean-list-linux-kernel@arctic.org
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329064705.2b0692ce.pj@engr.sgi.com>
In-Reply-To: <1112083503.20919.23.camel@frecb000711.frec.bull.fr>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112083503.20919.23.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume wrote:
> Yes, dean's suggestion helps. The overhead is now around 4%

More improvement than I expected (and I see a CBUS result further
down in my inbox).

Does this include a minimal consumer task of the data that writes
it to disk?

> I think that it can be moved in include/linux/connector.h 

Good.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
