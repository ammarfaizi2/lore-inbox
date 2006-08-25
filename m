Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422881AbWHYUCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbWHYUCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422884AbWHYUCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:02:20 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:43982 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422881AbWHYUCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:02:18 -0400
Date: Fri, 25 Aug 2006 22:07:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Howells <dhowells@redhat.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] [PATCH] BLOCK: Move extern declarations out of fs/*.c into header files [try #4]
Message-ID: <20060825200715.GB2629@uranus.ravnborg.org>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com> <20060825193712.11384.67875.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825193712.11384.67875.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:37:12PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Create a new header file, fs/internal.h, for common definitions local to the
> sources in the fs/ directory.
> 
> Move extern definitions that should be in header files from fs/*.c to
> fs/internal.h or other main header files where they span directories.

Why not fsinternal.h to make it explicit this is fs internal stuff.
This makes it a bit more obvious when lookign at the filename isolated.

	Sam
