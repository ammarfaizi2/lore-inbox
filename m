Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbTEOQqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbTEOQqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:46:10 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:62439 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264113AbTEOQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:45:01 -0400
Date: Thu, 15 May 2003 13:41:57 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030515134157.H672@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <shsn0hqoj5c.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <shsn0hqoj5c.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, May 13, 2003 at 07:23:27PM +0200
X-Spam-Score: -4.7 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19GM3C-0006BK-00*FKUhuqDxEgs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 07:23:27PM +0200, Trond Myklebust wrote:
> Under normal circumstances, changing real uid/gid should involve
> changing your PAG, but it doesn't necessarily have to do so.

It should not change your PAG, because otherwise a key principle
of PAGs (root is not able to get into a PAG with "su $UID") is lost.

Regards

Ingo Oeser
