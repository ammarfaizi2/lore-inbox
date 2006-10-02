Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWJBPb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWJBPb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWJBPbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:31:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964782AbWJBPbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:31:25 -0400
Date: Mon, 2 Oct 2006 08:31:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] jfs update
In-Reply-To: <20061002151612.6AB5A83A2B@kleikamp.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0610020827390.3952@g5.osdl.org>
References: <20061002151612.6AB5A83A2B@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Dave Kleikamp wrote:
>
>     Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
>     (cherry picked from f74156539964d7b3d5164fdf8848e6a682f75b97 commit)

Btw, these cherry-pick messages are useless (and just noise) when sending 
to me, since nobody will likely ever see the private tree that you 
cherry-picked from, so the SHA1 won't ever match anything meaningful for 
anybody but you.

So please either edit it out by hand ("git cherry-pick -e") or just ask 
git to not generate it at all (the "-r" flag, for "replay"). I thought git 
had already been fixed to not do this by default, but maybe I was 
dreaming.

			Linus
