Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030636AbWHIKPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030636AbWHIKPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030638AbWHIKPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:15:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030636AbWHIKPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:15:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608090116.38476.rjw@sisk.pl> 
References: <200608090116.38476.rjw@sisk.pl>  <200608081639.38245.rjw@sisk.pl> <20060804192540.17098.39244.stgit@warthog.cambridge.redhat.com> <32278.1155057836@warthog.cambridge.redhat.com> 
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ReiserFS: Make sure all dentries refs are released before calling kill_block_super() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 09 Aug 2006 11:14:27 +0100
Message-ID: <6818.1155118467@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rjw@sisk.pl> wrote:

> It didn't apply cleanly to -rc3-mm2 for me and produces the appended oops
> every time at the kernel startup (on x86_64).

Can you send me your modified patch?

David
