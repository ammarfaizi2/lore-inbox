Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWGFTC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWGFTC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWGFTC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:02:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750704AbWGFTC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:02:56 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060706113922.ac32eff3.akpm@osdl.org> 
References: <20060706113922.ac32eff3.akpm@osdl.org>  <20060706103134.197c8679.akpm@osdl.org> <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124721.7098.50514.stgit@warthog.cambridge.redhat.com> <25855.1152210303@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] FRV: Fix FRV arch compile errors [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 06 Jul 2006 20:02:44 +0100
Message-ID: <26605.1152212564@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Right now we're showing a grand total of two identifiers tagged with
> __initdata in all of include/.  Why isn't FRV blowing up all over the
> place?  Is there something about nr_kernel_pages which made us get unlucky?

There used to be more than that, IIRC.  It's possible that they've mostly been
localised to single .c files.  I'll have to find the patch in which I dealt
with this originally and look.

It may also be that there aren't that many anymore that aren't static and/or
aren't confined to arch code.

Davod
