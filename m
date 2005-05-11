Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVEKVMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVEKVMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVEKVMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:12:51 -0400
Received: from mail.shareable.org ([81.29.64.88]:47824 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262055AbVEKVMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:12:21 -0400
Date: Wed, 11 May 2005 22:11:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: serue@us.ibm.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511211134.GB5093@mail.shareable.org>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <20050511190545.GB14646@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511190545.GB14646@serge.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serue@us.ibm.com wrote:
> Right, sys_unshare(), as per Janak's patch.  Does it lack anything which
> you would need?

For creating new namespaces to be held by a daemon for handing out to
user processes on demand, it's no more convenient than clone().
Neither of them provide a facility to create multiple namespaces as
first-class objects, without switching to them.

-- Jamie
