Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSI3TH1>; Mon, 30 Sep 2002 15:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbSI3TH1>; Mon, 30 Sep 2002 15:07:27 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:64498 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261313AbSI3THW>; Mon, 30 Sep 2002 15:07:22 -0400
Subject: Re: [PATCH] 2.4.20 Direct IO patch for NFS. (Note: a trivial API
	change...)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chuck Lever <cel@netapp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
In-Reply-To: <20020930194227.A22095@infradead.org>
References: <15768.39196.468797.249573@charged.uio.no> 
	<20020930194227.A22095@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 20:18:20 +0100
Message-Id: <1033413501.17501.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 19:42, Christoph Hellwig wrote:
> I don't think changing the filesystem entry points during 2.4 is an option.

Its not a very hard change and we've made bigger changes than this
during the 2.4 VFS code. It would be a good idea to be able to tell
cleanly which version of the interface is present

