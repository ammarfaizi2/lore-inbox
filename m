Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966961AbWKULd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966961AbWKULd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966965AbWKULd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:33:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966961AbWKULd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:33:56 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0611201030400.3692@woody.osdl.org> 
References: <Pine.LNX.4.64.0611201030400.3692@woody.osdl.org>  <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> <20061120142716.12685.47219.stgit@warthog.cambridge.redhat.com> <4561CB33.2060502@s5r6.in-berlin.de> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] WorkStruct: Separate delayable and non-delayable events. 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 21 Nov 2006 11:30:53 +0000
Message-ID: <10202.1164108653@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> "dwork" just sounds d[w]orky. More importantly, we don't use short-hand 
> that isn't obvious, unless there is some industry-standard and old meaning 
> to it that everybody understands. "delayed_work" may be more typing, but 
> anybody who needs to type things that fast had better slow down anyway to 
> _think_.

Okay...  "delayed_work" it shall be.  Would it make sense to make another
wrapper about the common bit called "immediate_work" and then hide the common
bit entirely?

David
