Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWDUNC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWDUNC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWDUNC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:02:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13452 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932257AbWDUNCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:02:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060420171550.55f1b125.akpm@osdl.org> 
References: <20060420171550.55f1b125.akpm@osdl.org>  <20060420171922.GB21659@infradead.org> <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165935.9968.11060.stgit@warthog.cambridge.redhat.com> <21746.1145555150@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, hch@infradead.org, torvalds@osdl.org,
       steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] FS-Cache: Export find_get_pages() 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 21 Apr 2006 14:02:02 +0100
Message-ID: <13416.1145624522@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> that's an open-coded pagevec_lookup().

Whilst that's true, it is still slower to use pagevec_lookup().  But since you
insist, I'll do that anyway.

David
