Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTKZBfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 20:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTKZBfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 20:35:34 -0500
Received: from pat.uio.no ([129.240.130.16]:63153 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263840AbTKZBfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 20:35:33 -0500
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: can't lockf() over NFS
References: <Pine.LNX.4.58.0311251613230.20810@lucy.dcs.qmul.ac.uk>
	<20031125165501.A20302@build.pdx.osdl.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 25 Nov 2003 20:35:17 -0500
In-Reply-To: <20031125165501.A20302@build.pdx.osdl.net>
Message-ID: <shsznejzzca.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chris Wright <chrisw@osdl.org> writes:

     > Yes, can you either change your config to:

     > CONFIG_SECURITY=n

     > or:

     > CONFIG_SECURITY=y CONFIG_SECURITY_CAPABILITIES=y

     > or:

     > CONFIG_SECURITY=y CONFIG_SECURITY_CAPABILITIES=m and modprobe
     > capability

Sorry, yes. That one slipped my mind...

Cheers,
  Trond
