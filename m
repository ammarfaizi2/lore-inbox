Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWHURxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWHURxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 13:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWHURxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 13:53:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37271 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422734AbWHURxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 13:53:09 -0400
Date: Mon, 21 Aug 2006 10:51:06 -0700
From: Paul Jackson <pj@sgi.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: akpm@osdl.org, riel@redhat.com, Linux@sc8-sf-spam2-b.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, ak@suse.de, hch@infradead.org, saw@sw.ru,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Christoph@sc8-sf-spam2-b.sourceforge.net, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, xemul@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
Message-Id: <20060821105106.6688c92c.pj@sgi.com>
In-Reply-To: <44E9B69D.9060109@sw.ru>
References: <44E33893.6020700@sw.ru>
	<44E33C3F.3010509@sw.ru>
	<1155752277.22595.70.camel@galaxy.corp.google.com>
	<1155755069.24077.392.camel@localhost.localdomain>
	<1155756170.22595.109.camel@galaxy.corp.google.com>
	<44E45D6A.8000003@sw.ru>
	<20060817084033.f199d4c7.akpm@osdl.org>
	<20060818120809.B11407@castle.nmd.msu.ru>
	<1155912348.9274.83.camel@localhost.localdomain>
	<20060818094248.cdca152d.akpm@osdl.org>
	<44E9B69D.9060109@sw.ru>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this doesn't allow memory overcommitment, does it?

Uh - no - I don't think so.  You can over commit
the memory of a task in a small cpuset just as well
as you can a task in a big cpuset or even one in the
top cpuset covering the entire system.

Perhaps I didn't understand your point.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
