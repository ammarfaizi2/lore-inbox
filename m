Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267737AbTBUWJh>; Fri, 21 Feb 2003 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTBUWJh>; Fri, 21 Feb 2003 17:09:37 -0500
Received: from pat.uio.no ([129.240.130.16]:21130 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267737AbTBUWJe>;
	Fri, 21 Feb 2003 17:09:34 -0500
To: Yours Lovingly <ylovingly@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange but consistent feature of linux nfs client
References: <20030221215721.71135.qmail@web8007.mail.in.yahoo.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Feb 2003 23:19:36 +0100
In-Reply-To: <20030221215721.71135.qmail@web8007.mail.in.yahoo.com>
Message-ID: <shsvfzd5laf.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Yours Lovingly <ylovingly@yahoo.co.in> writes:

     > I observed without exception in all test runs that the second
     > write-read combination had the read succeeding to find the data
     > in the local cache(after suitable revalidation etc) while the
     > first read operation in each individual test run never found
     > the data in the local cache(although the first write too like
     > the second write was done through the pagecache) or whatever
     > but invariably made an on the wire read - always.

     > So what is special - first time reads/first time writes and
     > why, and how is this speciality affected in the kernel.

You are perhaps failing to write an entire page?

Cheers,
  Trond
