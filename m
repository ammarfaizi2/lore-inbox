Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVC3Ghu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVC3Ghu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVC3Ghu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:37:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15515 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261762AbVC3Ghr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:37:47 -0500
Date: Tue, 29 Mar 2005 22:35:34 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: johnpol@2ka.mipt.ru, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329223534.62f78b0a.pj@engr.sgi.com>
In-Reply-To: <1112161183.20919.84.camel@frecb000711.frec.bull.fr>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112079856.5243.24.camel@uganda>
	<20050329004915.27cd0edf.pj@engr.sgi.com>
	<1112087822.8426.46.camel@frecb000711.frec.bull.fr>
	<20050329072335.52b06462.pj@engr.sgi.com>
	<1112161183.20919.84.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume wrote:
> When I wrote "several user space applications" it was just to say that
> this fork connector is not designed only for ELSA and fork information
> is available to every listeners.

So I suppose if fork_connector were not used to collect <parent pid,
child pid> information for accounting, then someone would have to make
the case that there were enough other uses, of sufficient value, to add
fork_connector.  We have to be a bit careful, in the kernel, to avoid
adding mechanisms until we have the immediate use in hand.  If we don't
do this, then the kernel ends up looking like the Gargoyles on a
Renaissance church - burdened with overly ornate features serving no
earthly purpose.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
