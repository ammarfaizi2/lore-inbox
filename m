Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTILSx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTILSxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:53:03 -0400
Received: from pat.uio.no ([129.240.130.16]:64747 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261811AbTILSvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:51:37 -0400
To: Marco Bertoncin - Sun Microsystems UK - Platform OS
	 Development Engineer <Marco.Bertoncin@Sun.COM>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: NFS/MOUNT/sunrpc problem?
References: <200309121743.h8CHhB114413@brk-mail1.uk.sun.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 12 Sep 2003 14:51:28 -0400
In-Reply-To: <200309121743.h8CHhB114413@brk-mail1.uk.sun.com>
Message-ID: <shsk78dj0wf.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marco Bertoncin <- Sun Microsystems UK - Platform OS Development Engineer <Marco.Bertoncin@Sun.COM>> writes:

     > This is a MOUNT req, not NFS, so we are using userland rpc?

Correct. Unless you are doing NFSroot (which was what I thought you
might be using)...
For ordinary NFSv2 and NFSv3 mounts, the 'mount' program talks
directly to the server, then passes the resulting filehandle down to
the kernel.

Cheers,
  Trond
