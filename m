Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSI3Slq>; Mon, 30 Sep 2002 14:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbSI3Slq>; Mon, 30 Sep 2002 14:41:46 -0400
Received: from pat.uio.no ([129.240.130.16]:37523 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261403AbSI3Slp>;
	Mon, 30 Sep 2002 14:41:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15768.39971.417077.834216@charged.uio.no>
Date: Mon, 30 Sep 2002 20:46:59 +0200
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chuck Lever <cel@netapp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] 2.4.20 Direct IO patch for NFS. (Note: a trivial API change...)
In-Reply-To: <20020930194227.A22095@infradead.org>
References: <15768.39196.468797.249573@charged.uio.no>
	<20020930194227.A22095@infradead.org>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christoph Hellwig <hch@infradead.org> writes:

     > I don't think changing the filesystem entry points during 2.4
     > is an option.

DirectIO was added in the middle of the 2.4 'stable' period without
any discussion. It should not benefit from the same protection that
the standard APIs do.

Cheers,
  Trond
