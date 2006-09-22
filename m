Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWIVMbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWIVMbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWIVMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:31:22 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:37516 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932373AbWIVMbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:31:21 -0400
Date: Fri, 22 Sep 2006 14:31:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, evil@g-house.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] AFS: Manage AFS modularity vs FS-Cache modularity
Message-ID: <20060922123105.GA3767@wohnheim.fh-wedel.de>
References: <20060922111137.16615.7794.stgit@warthog.cambridge.redhat.com> <20060922111140.16615.46012.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060922111140.16615.46012.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 September 2006 12:11:40 +0100, David Howells wrote:
>
>  	bool "Provide AFS client caching support"
                                                 (EXPERIMENTAL) ?
> -	depends on AFS_FS && FSCACHE && EXPERIMENTAL
>  	  Say Y here if you want AFS data to be cached locally on through the
                                                                 disk ?

At least I cannot see why the AFS patch differs from the NFS one in
those two details.

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf
