Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSEWIpc>; Thu, 23 May 2002 04:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316414AbSEWIpb>; Thu, 23 May 2002 04:45:31 -0400
Received: from pat.uio.no ([129.240.130.16]:13741 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316390AbSEWIpb>;
	Thu, 23 May 2002 04:45:31 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: imipak@yahoo.com (Myrddin Ambrosius),
        "William A.(Andy) Adamson" <andros@umich.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
In-Reply-To: <E17Ab0Y-0002We-00@the-village.bc.nu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 May 2002 10:45:05 +0200
Message-ID: <shsn0ur45im.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > What of it do you actually need in kernel space - encrypted
     > file systems certainly ought to be there but are not very well
     > handled in Linux proper right now - but anything else ?

Authentication...

At the Connectathon in February, we got as far as setting up a working
test machine for the RPCSEC_GSS kerberos V5 authentication on the NFS
and RPC clients. AFAIK, Andy is currently working on adding support
for SPKM auth. and data encryption.

I'm not sure exactly which ciphers we need for all this (Andy can
perhaps comment?) but we'd definitely want to see part of the crypto
patches go into the standard kernel at some point soon.

Cheers,
  Trond
