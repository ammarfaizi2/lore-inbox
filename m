Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbWFIVns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbWFIVns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbWFIVns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:43:48 -0400
Received: from hera.kernel.org ([140.211.167.34]:59095 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030526AbWFIVnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:43:47 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Date: Fri, 9 Jun 2006 14:43:23 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6cq1r$foi$1@terminus.zytor.com>
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com> <4489D36C.3010000@garzik.org> <20060609203523.GE10524@thunk.org> <4489EAFE.6090303@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149889403 16147 127.0.0.1 (9 Jun 2006 21:43:23 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 9 Jun 2006 21:43:23 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4489EAFE.6090303@garzik.org>
By author:    Jeff Garzik <jeff@garzik.org>
In newsgroup: linux.dev.kernel
>
> Theodore Tso wrote:
> > And I'd also dispute with your "weren't really suited for the original
> > ext2-style design" comment.  Ext2/3 was always designed to be
> > extensible from the start, and we've successfully added features quite
> > successfully for quite a while.
> 
> Although not the only disk format change, extents are a pretty big one. 
> Will this be the last major on-disk format change?
> 

"Last" is a pretty strong word.  Will extents be combined with 64-bit
block numbers?  That's becoming increasingly urgent.

	-hpa

