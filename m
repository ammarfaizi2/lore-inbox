Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWHYUUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWHYUUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWHYUUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:20:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5803 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932236AbWHYUUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:20:07 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060825200715.GB2629@uranus.ravnborg.org> 
References: <20060825200715.GB2629@uranus.ravnborg.org>  <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com> <20060825193712.11384.67875.stgit@warthog.cambridge.redhat.com> 
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] [PATCH] BLOCK: Move extern declarations out of fs/*.c into header files [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 21:20:02 +0100
Message-ID: <22086.1156537202@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:

> Why not fsinternal.h to make it explicit this is fs internal stuff.
> This makes it a bit more obvious when lookign at the filename isolated.

Consistency:

	warthog>echo */internal.h
	crypto/internal.h fs/internal.h mm/internal.h
	warthog>echo */*/internal.h
	fs/afs/internal.h fs/nfs/internal.h fs/proc/internal.h fs/ramfs/internal.h net/rxrpc/internal.h security/keys/internal.h

David
