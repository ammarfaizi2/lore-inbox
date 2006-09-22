Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWIVOSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWIVOSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWIVOSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:18:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932521AbWIVOSE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:18:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060922123105.GA3767@wohnheim.fh-wedel.de> 
References: <20060922123105.GA3767@wohnheim.fh-wedel.de>  <20060922111137.16615.7794.stgit@warthog.cambridge.redhat.com> <20060922111140.16615.46012.stgit@warthog.cambridge.redhat.com> 
To: =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FJ=3DF6rn=3F=3D?= Engel 
	<joern@wohnheim.fh-wedel.de>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, evil@g-house.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] AFS: Manage AFS modularity vs FS-Cache modularity 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Fri, 22 Sep 2006 15:17:51 +0100
Message-ID: <20773.1158934671@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> At least I cannot see why the AFS patch differs from the NFS one in
> those two details.

Actually, what the patch itself changes doesn't differ significantly - the
difference is in the patch context.

> >  	bool "Provide AFS client caching support"
>                                                  (EXPERIMENTAL) ?

Well, AFS_FS is itself marked as being experimental, so I'm not sure that the
AFS_FSCACHE option needs to be also.

David
