Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVLHN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVLHN6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLHN6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:58:48 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:36414 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932111AbVLHN6r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:58:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YZ1xPWPRlChVO5lNK+L3ehp/ugvntSThcX6zjDVz49PNbyxytPV22WpetVjqsfbTGvFAGd/fVcFopJuTeh0EGPRgw1DYkk98fTeHfMJpr5oLz3cpqNbXnk7yePlC/yudDogokzLKtRltCDfLmi46u5obPkNcFNXkvc7qCxeciqo=
Message-ID: <84144f020512080558tb9bb6bbjf91e72ad3d9ccaa6@mail.gmail.com>
Date: Thu, 8 Dec 2005 15:58:46 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Hellwig <hch@infradead.org>,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, michaelc@cs.wisc.edu,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       open-iscsi@googlegroups.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: allowed pages in the block later, was Re: [Ext2-devel] [PATCH] ext3: avoid sending down non-refcounted pages
In-Reply-To: <20051208134239.GA13376@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051208180900T.fujita.tomonori@lab.ntt.co.jp>
	 <20051208101833.GM14509@schatzie.adilger.int>
	 <20051208134239.GA13376@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 12/8/05, Christoph Hellwig <hch@infradead.org> wrote:
> One way to work around that would be to detect kmalloced pages and use
> a slowpath for that.  The major issues with that is that we don't have a
> reliable way to detect if a given struct page comes from the slab allocator
> or not.

Why doesn't PageSlab work for you?

                                                          Pekka
