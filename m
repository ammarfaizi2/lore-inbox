Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268592AbUHYUid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268592AbUHYUid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUHYU2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:28:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25823 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268598AbUHYUZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:25:27 -0400
Date: Wed, 25 Aug 2004 16:25:24 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hans Reiser <reiser@namesys.com>
cc: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant
 architect in the USA for Phase I of a DARPA funded linux kernel project
In-Reply-To: <410D96DC.1060405@namesys.com>
Message-ID: <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Hans Reiser wrote:

> You can think of this as chroot on steroids.

Sounds like what you want is pretty much the namespace stuff
that has been in the kernel since the early 2.4 days.

No need to replicate VFS functionality inside the filesystem.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

