Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWDUT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWDUT3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWDUT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:29:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36265 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932320AbWDUT3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:29:21 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060421112243.4b435bc7.akpm@osdl.org> 
References: <20060421112243.4b435bc7.akpm@osdl.org>  <20060420170754.39294603.akpm@osdl.org> <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com> <4816.1145622827@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       sct@redhat.com, aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific open files 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 21 Apr 2006 20:29:07 +0100
Message-ID: <17512.1145647747@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> argh, I forgot about the flag.  Oh well.  I'd suggest:

I presume you mean for the second to pass an argument of 1 to
__get_empty_filp().

David
