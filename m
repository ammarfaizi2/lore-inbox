Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271754AbTG2OEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271755AbTG2OEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:04:33 -0400
Received: from pat.uio.no ([129.240.130.16]:31882 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S271754AbTG2OE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:04:29 -0400
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
References: <20030728225947.GA1694@localhost.localdomain>
	<20030729072440.A12426@animx.eu.org>
	<20030729130400.GA4052@localhost.localdomain>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Jul 2003 16:03:59 +0200
In-Reply-To: <20030729130400.GA4052@localhost.localdomain>
Message-ID: <shsr8494egg.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Balram Adlakha <b_adlakha@softhome.net> writes:

     > I'll try with the kernel NFS then, any idea why this happens?

Yes... The userland NFS server only supports the NFSv2 protocol, which
again only supports filesizes < 2GB.

Cheers,
  Trond
