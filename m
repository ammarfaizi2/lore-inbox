Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbSJDOfO>; Fri, 4 Oct 2002 10:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSJDOfO>; Fri, 4 Oct 2002 10:35:14 -0400
Received: from pat.uio.no ([129.240.130.16]:19452 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261835AbSJDOfN>;
	Fri, 4 Oct 2002 10:35:13 -0400
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: David Howells <dhowells@cambridge.redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
References: <jaharkes@cs.cmu.edu>
	<20021003165304.GA25718@ravel.coda.cs.cmu.edu>
	<15381.1033681790@warthog.cambridge.redhat.com>
	<20021004140229.GA11066@ravel.coda.cs.cmu.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Oct 2002 16:40:41 +0200
In-Reply-To: <20021004140229.GA11066@ravel.coda.cs.cmu.edu>
Message-ID: <shsheg2i7x2.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jan Harkes <jaharkes@cs.cmu.edu> writes:

    >> Besides, I get the impression that NFSv4 may require some level
    >> of kerberos support in the kernel.

     > If not kerberos, at least some for of encryption. IP/Sec would
     > need the same things.

NFSv4 does indeed require the full kerberos encryption stuff in the
kernel. The RFC specifies that krb5 support is a minimum requirement,
and we will expect to have that in 2.6 (or 3.0 or whatever it's called
these days...)

Cheers,
  Trond
