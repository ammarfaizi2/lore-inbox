Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbTGHOrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbTGHOrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:47:24 -0400
Received: from pat.uio.no ([129.240.130.16]:25335 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S267260AbTGHOrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:47:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16138.56467.342593.715679@charged.uio.no>
Date: Tue, 8 Jul 2003 17:00:35 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: trond.myklebust@fys.uio.no, Marcelo Tosatti <marcelo@conectiva.com.br>,
       hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] Fastwalk: reduce cacheline bouncing of d_count (Changelog@1.1024.1.11)
In-Reply-To: <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk>
References: <16138.53118.777914.828030@charged.uio.no>
	<1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > I was a little suprised it went in, it never seemed a candidate
     > for dealing with a stable tree, just optimisation stuff that is
     > 2.5 material only

As you can see, I screwed up on the title, so I may have confused
you...
...but I do agree with your comment. The patch I meant to refer to
(see revised title) does not appear in the 2.5.x tree either.

Have we BTW been shown any numbers that support the alleged benefits?
I may have missed those...

Cheers,
  Trond
