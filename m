Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTEROvZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTEROvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:51:24 -0400
Received: from pat.uio.no ([129.240.130.16]:62084 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262101AbTEROvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:51:24 -0400
To: Jim Nance <jlnance@us54.synopsys.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, jlnance@unity.ncsu.edu,
       linux-kernel@vger.kernel.org, gary.nifong@synopsys.COM,
       James.Nance@synopsys.COM, david.thomas@synopsys.COM
Subject: Re: NFS problems with Linux-2.4
References: <20030513145023.GA10383@ncsu.edu>
	<16065.3323.449992.207039@charged.uio.no>
	<20030515112231.A28148@synopsys.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 May 2003 17:00:24 +0200
In-Reply-To: <20030515112231.A28148@synopsys.com>
Message-ID: <shsznlkjo53.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry. stat doesn't obey close-to-open. It relies on standard
attribute caching. close-to-open means "open()" (and only "open()")
checks data cache consistency...

Cheers,
  Trond
