Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUHZNmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUHZNmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268866AbUHZNmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:42:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31367 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268845AbUHZNkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:40:55 -0400
Date: Thu, 26 Aug 2004 09:39:35 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Spam <spam@tnonline.net>
cc: Andrew Morton <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>,
       <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1453776111.20040826131547@tnonline.net>
Message-ID: <Pine.LNX.4.44.0408260938340.26316-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Spam wrote:

>   Yes, JPEG, TIFF and PNG files for example. But, if you modify any of
>   these  with  an application that doesn't support the extensions then
>   you will loose them.

OK, so we've got a choice.

Either we will lose the extensions when modifying the file
with an unaware program, or you lose the extensions when
copying (or restoring from backup) using an unaware program.

Personally I'd prefer to keep the file intact when not
modifying it...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

