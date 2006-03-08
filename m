Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWCHMPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWCHMPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWCHMPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:15:03 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:60396 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932506AbWCHMPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:15:01 -0500
Date: Wed, 8 Mar 2006 05:14:59 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Optimise d_find_alias() [try #6]
Message-ID: <20060308121459.GG7301@parisc-linux.org>
References: <440D76A4.8050703@yahoo.com.au> <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com> <20060307113404.23330.71158.stgit@warthog.cambridge.redhat.com> <25795.1141737864@warthog.cambridge.redhat.com> <440E945A.1050404@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440E945A.1050404@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 07:22:50PM +1100, Nick Piggin wrote:
> Also: I might be talking complete crap here, so anyone feel free to ridicule
> me if I'm wrong.

No, the smb_rmb() is unnecessary.  akpm was the only one who thought we
needed it originally, it just somehow stayed into this iteration of the patch.
