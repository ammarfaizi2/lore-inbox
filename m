Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTKCQJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTKCQJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:09:59 -0500
Received: from pat.uio.no ([129.240.130.16]:63737 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262070AbTKCQJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:09:58 -0500
To: Voluspa <lista2@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS on 2.6.0-test9:
References: <20031103163455.57d24178.lista2@comhem.se>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 Nov 2003 11:09:54 -0500
In-Reply-To: <20031103163455.57d24178.lista2@comhem.se>
Message-ID: <shssml5o2lp.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == lista2  <Voluspa> writes:

     > Using TCP or DIRECTIO in -test9 makes no difference. Here's the
     > relevant .config-section:

So where *does* the big jump from 3 minutes to 29 minutes occur? Are
those numbers on TCP or are they UDP only?

What NIC are you using? From the error logs you showed us, it looked
like it might be a de4x5 driver. Have you tried using the tulip
driver?

Are you using ACPI to set up the hardware? If so, does turning it off
make a difference.

Does 'netstat -s' offer any other hints?

Cheers,
  Trond
