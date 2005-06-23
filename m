Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVFWSD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVFWSD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVFWSD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:03:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60590 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262637AbVFWSDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:03:51 -0400
Date: Thu, 23 Jun 2005 14:03:35 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Mark Fasheh <mark.fasheh@oracle.com>
cc: linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>,
       <ocfs2-devel@oss.oracle.com>, <torvalds@osdl.org>, <akpm@osdl.org>,
       <wim.coekaerts@oracle.com>, <lmb@suse.de>
Subject: Re: [RFC] [PATCH] OCFS2
In-Reply-To: <20050518223303.GE1340@ca-server1.us.oracle.com>
Message-ID: <Xine.LNX.4.44.0506231358230.14123-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Mark Fasheh wrote:

> This is OCFS2, a shared disk cluster file system which we hope will be
> included in the kernel.

The masklog code looks potentially useful outside of ocfs2, as a general 
kernel facility.  Any chance of splitting it out?


Quibbles:

- A lot of the macros should probably be replaced with static inlines, 
like OCFS2_IS_VALID_DINODE.

- Approx. 80 typedefs.  ouch.



-- 
James Morris
<jmorris@redhat.com>


