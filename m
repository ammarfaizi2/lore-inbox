Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTHTTJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTHTTJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:09:53 -0400
Received: from pat.uio.no ([129.240.130.16]:47318 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262146AbTHTTJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:09:52 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Steve Dickson <SteveD@redhat.com>, nfs@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>, acl-devel@bestbits.at
Subject: Re: [NFS] [PATCH] Stop call_decode() from ignorning RPC header errrors
References: <3F43B13C.5010403@RedHat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Aug 2003 12:09:17 -0700
In-Reply-To: <3F43B13C.5010403@RedHat.com>
Message-ID: <shsekzgxi1u.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steve Dickson <SteveD@redhat.com> writes:

     > This patch stop call_decode() from ignoring errors that are
     > found while parsing the RPC header. I turns out the nfs acls
     > routines need these error codes to do the right thing...

Duh... Yeah... That is broken in 2.4.22-rc2, and it's not only the NFS
ACLs that will break.

Marcelo, could you please apply?

Cheers,
  Trond
