Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVA0KsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVA0KsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVA0KmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:42:11 -0500
Received: from main.gmane.org ([80.91.229.2]:33001 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262563AbVA0Kd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:33:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nuutti Kotivuori <naked@iki.fi>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
Date: Thu, 27 Jan 2005 12:33:10 +0200
Organization: Ye 'Ol Disorganized NNTPCache groupie
Message-ID: <87brbb9n6h.fsf@aka.i.naked.iki.fi>
References: <20050102162652.GA12268@lkcl.net> <200501050111.59072.arnd@arndb.de>
 <Pine.LNX.4.61.0501211634380.15744@chimarrao.boston.redhat.com>
 <200501262056.50981.maw48@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: naked.iki.fi
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Corporate Culture,
 linux)
Cancel-Lock: sha1:yAMwwyOpYkm41O5APJRt7d90230=
Cache-Post-Path: aka.i.naked.iki.fi!unknown@aka.i.naked.iki.fi
X-Cache: nntpcache 3.0.1 (see http://www.nntpcache.org/)
Cc: xen-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Williamson wrote:
> If multiple platforms want to do this, we could refactor the code so
> that the core of the balloon driver can be used in multiple archs.
> We could have an arch_release/request_memory() that the core balloon
> driver can call into to actually return memory to the VMM.

This is also a thing that the UML project would probably be interested
in.

As a generalization though, what is needed is hot-pluggable memory in
Linux kernel. Satisfies Xen, UML and any physical implementations at
some point.

-- Naked


