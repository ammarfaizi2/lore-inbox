Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264759AbSJOQhQ>; Tue, 15 Oct 2002 12:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264760AbSJOQhP>; Tue, 15 Oct 2002 12:37:15 -0400
Received: from ns.suse.de ([213.95.15.193]:39698 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264759AbSJOQhO> convert rfc822-to-8bit;
	Tue, 15 Oct 2002 12:37:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Date: Tue, 15 Oct 2002 18:43:08 +0200
User-Agent: KMail/1.4.3
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015171606.A29069@infradead.org> <20021015162119.GF15552@clusterfs.com>
In-Reply-To: <20021015162119.GF15552@clusterfs.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210151843.08591.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 18:21, Andreas Dilger wrote:
> Is there a reason why the code can't just add items into the list in
> the reverse order (i.e. list_add_tail()) and then walk in the normal
> direction via list_for_each_safe()?

No it could well be reversed.

--Andreas.
