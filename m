Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbTJJPpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTJJPpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:45:08 -0400
Received: from pat.uio.no ([129.240.130.16]:16526 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262954AbTJJPpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:45:04 -0400
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: net/sunrpc/clnt.c compilation error: tk_pid field
References: <buo65ixv63j.fsf@mcspd15.ucom.lsi.nec.co.jp>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 10 Oct 2003 11:44:52 -0400
In-Reply-To: <buo65ixv63j.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <shs3ce1ksgb.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Miles Bader <miles@lsi.nec.co.jp> writes:

     > With linux-2.6.0-test7, I get compilation errors like:
     >      CC net/sunrpc/clnt.o
     >    net/sunrpc/clnt.c:965: structure has no member named
     >    `tk_pid' net/sunrpc/clnt.c:970: structure has no member
     >    named `tk_pid' net/sunrpc/clnt.c:976: structure has no
     >    member named `tk_pid' make[2]: *** [net/sunrpc/clnt.o] Error
     >    1

See yesterday's discussion of this very same topic on this very same
list. A fix is already in Linus' bitkeeper repository...

Cheers,
   Trond
