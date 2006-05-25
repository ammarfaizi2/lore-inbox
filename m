Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWEYL7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWEYL7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 07:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWEYL7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 07:59:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20373 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965123AbWEYL7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 07:59:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1060522044652.31268@suse.de> 
References: <1060522044652.31268@suse.de>  <20060522143524.25410.patches@notabene> 
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 2] Prepare for __copy_from_user_inatomic to not zero missed bytes. 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 25 May 2006 12:59:03 +0100
Message-ID: <19591.1148558343@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NeilBrown <neilb@suse.de> wrote:

> Interestingly 'frv' disables preempt in kmap_atomic, but its
> copy_from_user doesn't expect faults and never zeros the tail...

What gives you the idea that copy_from_user() on FRV doesn't expect or handle
faults when CONFIG_MMU is set?  And why do you say it never zeroes the tail?

David
