Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSFATJg>; Sat, 1 Jun 2002 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSFATJf>; Sat, 1 Jun 2002 15:09:35 -0400
Received: from pat.uio.no ([129.240.130.16]:24546 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S314748AbSFATJe>;
	Sat, 1 Jun 2002 15:09:34 -0400
To: Kenneth Johansson <ken@canit.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: nfs problem 2.4.19-pre9
In-Reply-To: <1022940144.1186.35.camel@tiger>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 01 Jun 2002 21:09:28 +0200
Message-ID: <shs8z5yrf2v.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Kenneth Johansson <ken@canit.se> writes:

     > I have had a problem for some time that processes get stuck in
     > D state and I now have a way to get this to happen at will.

     > One way to do this is to copy a file from one nfs mounted
     > directory to another. It dose not happen on the same mount and
     > not when copying from nfs to a local disk. To make this even
     > more complex it works with cp and mv but not in mc(midnight
     > commander F6 ).

Sounds like a network driver problem or something like that. UDP
appears to trigger these lockups a lot more easily than does TCP.

Try testing with a different brand of networking card...

Cheers,
   Trond
