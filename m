Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVCIAoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVCIAoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVCIAkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:40:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:56557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262230AbVCIAiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:38:18 -0500
Date: Tue, 8 Mar 2005 16:37:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: miklos@szeredi.hu, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
 [try #3]
Message-Id: <20050308163759.2ff4be57.akpm@osdl.org>
In-Reply-To: <21199.1110291151@redhat.com>
References: <20050307121416.78381632.akpm@osdl.org>
	<E1D8KPt-00058Y-00@dorka.pomaz.szeredi.hu>
	<E1D8K3T-00056q-00@dorka.pomaz.szeredi.hu>
	<20050307041047.59c24dec.akpm@osdl.org>
	<20050307034747.4c6e7277.akpm@osdl.org>
	<20050307033734.5cc75183.akpm@osdl.org>
	<20050303123448.462c56cd.akpm@osdl.org>
	<20050302135146.2248c7e5.akpm@osdl.org>
	<20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
	<13767.1109857095@redhat.com>
	<9268.1110194624@redhat.com>
	<9741.1110195784@redhat.com>
	<9947.1110196314@redhat.com>
	<22447.1110204304@redhat.com>
	<24382.1110210081@redhat.com>
	<24862.1110211603@redhat.com>
	<E1D8Ksv-0005Br-00@dorka.pomaz.szeredi.hu>
	<21199.1110291151@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch replaces backing_dev_info::memory_backed with capabilitied
> bitmap.

Looks sane to me, thanks.

I hope you got all the conversions correct - breakage in the writeback
dirty accounting manifests in subtle ways. I'll double-check it.
