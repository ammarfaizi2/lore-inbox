Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVCIK27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVCIK27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVCIK2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:28:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20456 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262276AbVCIK17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:27:59 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050308163759.2ff4be57.akpm@osdl.org> 
References: <20050308163759.2ff4be57.akpm@osdl.org>  <20050307121416.78381632.akpm@osdl.org> <E1D8KPt-00058Y-00@dorka.pomaz.szeredi.hu> <E1D8K3T-00056q-00@dorka.pomaz.szeredi.hu> <20050307041047.59c24dec.akpm@osdl.org> <20050307034747.4c6e7277.akpm@osdl.org> <20050307033734.5cc75183.akpm@osdl.org> <20050303123448.462c56cd.akpm@osdl.org> <20050302135146.2248c7e5.akpm@osdl.org> <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> <13767.1109857095@redhat.com> <9268.1110194624@redhat.com> <9741.1110195784@redhat.com> <9947.1110196314@redhat.com> <22447.1110204304@redhat.com> <24382.1110210081@redhat.com> <24862.1110211603@redhat.com> <E1D8Ksv-0005Br-00@dorka.pomaz.szeredi.hu> <21199.1110291151@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: miklos@szeredi.hu, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information [try #3] 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 09 Mar 2005 10:27:38 +0000
Message-ID: <18569.1110364058@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote:

> > The attached patch replaces backing_dev_info::memory_backed with
> > capabilitied bitmap.
> 
> Looks sane to me, thanks.
> 
> I hope you got all the conversions correct - breakage in the writeback
> dirty accounting manifests in subtle ways. I'll double-check it.

I think I got the logic as-was. This is quite easy to check just by looking at
the patch. However, the as-was logic should possibly be changed to reflect the
fact that the one control that there was has now been split into two.

David
