Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSIEMjk>; Thu, 5 Sep 2002 08:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSIEMjj>; Thu, 5 Sep 2002 08:39:39 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:18693 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315762AbSIEMjj>; Thu, 5 Sep 2002 08:39:39 -0400
Date: Thu, 5 Sep 2002 13:44:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905134414.A1784@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20020904233528.GA1238@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020904233528.GA1238@dualathlon.random>; from andrea@suse.de on Thu, Sep 05, 2002 at 01:35:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only in 2.4.20pre5aa1: 00_prepare-write-fixes-3-1
> 
> 	Also check the i_size is in sync with the last block we allocated in
> 	the metadata, it won't be updated in the commit_write if prepare_write
> 	is failing.

When testing -aa + my xfs update without the 9* series. this gave an compile
error.  Any chance you could move it after 96_inode_read_write-atomic-4?

