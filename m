Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTIKChs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTIKChs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:37:48 -0400
Received: from pat.uio.no ([129.240.130.16]:51898 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264156AbTIKChq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:37:46 -0400
To: Marco Bertoncin - Sun Microsystems UK - Platform OS
	 Development Engineer <Marco.Bertoncin@Sun.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS/MOUNT/sunrpc problem?
References: <200309101437.h8AEbV108262@brk-mail1.uk.sun.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 10 Sep 2003 22:37:43 -0400
In-Reply-To: <200309101437.h8AEbV108262@brk-mail1.uk.sun.com>
Message-ID: <shs65k0rqx4.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marco Bertoncin <- Sun Microsystems UK - Platform OS Development Engineer <Marco.Bertoncin@Sun.COM>> writes:


     > switch.  How to reproduce
     > - During install a MOUNT (V2) request is sent to the install
     >   server
     > - the ACK is dropped
     > Symptom
     > - the blade, after 3 seconds, starts a storm of retransmit
     >   (MOUNT reqs) that
     > won't stop, unless an ACK (one of the several ACKS sent for
     > each retransmitted requests) has the chance to get
     > through. This is sometimes after a few hundreds packets,
     > sometimes after a lot more, causing an apparent hang of the
     > installation process, and what's even worse, bringing to a
     > grinding halt the server (bombarded by near 1Gbit/sec packets).

Have you tried a more recent kernel? 2.4.18 was released more than one
and a half years ago...

Cheers,
  Trond
