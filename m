Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262189AbSJDP5r>; Fri, 4 Oct 2002 11:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSJDP5r>; Fri, 4 Oct 2002 11:57:47 -0400
Received: from pat.uio.no ([129.240.130.16]:65158 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262189AbSJDP5q>;
	Fri, 4 Oct 2002 11:57:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15773.48067.804268.678391@charged.uio.no>
Date: Fri, 4 Oct 2002 18:03:15 +0200
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2) 
In-Reply-To: <27402.1033746973@warthog.cambridge.redhat.com>
References: <trond.myklebust@fys.uio.no>
	<15773.47490.564575.814249@charged.uio.no>
	<27402.1033746973@warthog.cambridge.redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Howells <dhowells@cambridge.redhat.com> writes:

    >> Whereas I doubt that AFS uses RPCSEC_GSS, I believe that the
    >> kerberos code itself (+ upcall mechanism for getting user
    >> tokens etc.) could be reused by you. I presume that you would
    >> make use of the sunrpc code too?

     > I would if I could, but RxRPC is a sufficiently different
     > protocol to make that impractical:-/

How badly does it differ? If you are talking only about a couple of
differences in the RPC headers, then that is something that can easily
be overcome...

Cheers,
  Trond
