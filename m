Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTENQ7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTENQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:59:15 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:22428 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262671AbTENQ7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:59:12 -0400
Date: Wed, 14 May 2003 13:11:58 -0400
To: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support, try #2
Message-ID: <20030514171157.GE20171@delft.aura.cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
References: <24225.1052909011@warthog.warthog> <20030514165838.GD20171@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514165838.GD20171@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I said that was my last mail, but I just noticed a really bad typo

On Wed, May 14, 2003 at 12:58:38PM -0400, Jan Harkes wrote:
> AFS (and possibly DFS) style token management uses both the user id
> (fsuid?) and PAG id. It has simple rules,
> 
>    All processes with (pag == 0 and same uid) share the same tokens.
>    All processes with pag != 0 share the same tokens.
		        ^^^^^^^^
		     the same non-zero pag

Jan
