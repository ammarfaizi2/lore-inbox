Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbVHJW4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVHJW4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVHJW4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:56:45 -0400
Received: from smtp.istop.com ([66.11.167.126]:24754 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932587AbVHJW4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:56:44 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
Date: Thu, 11 Aug 2005 08:57:05 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hugh Dickins <hugh@veritas.com>,
       David Howells <dhowells@redhat.com>
References: <42F57FCA.9040805@yahoo.com.au> <200508110823.53593.phillips@arcor.de> <1123713258.10292.109.camel@lade.trondhjem.org>
In-Reply-To: <1123713258.10292.109.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508110857.06539.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On Thursday 11 August 2005 08:34, Trond Myklebust wrote:
> to den 11.08.2005 Klokka 08:23 (+1000) skreiv Daniel Phillips:
> > Note: I have not fully audited the NFS-related colliding use of page
> > flags bit 8, to verify that it really does not escape into VFS or MM from
> > NFS, in fact I have misgivings about end_page_fs_misc which uses this
> > flag but has no in-tree users to show how it is used and, hmm, isn't even
> > _GPL.  What is up?
>
> What "NFS-related colliding use of page flags bit 8"?

As explained to me:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112368417412580&w=2

Regards,

Daniel
