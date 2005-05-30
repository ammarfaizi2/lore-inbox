Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVE3NkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVE3NkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 09:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVE3NkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 09:40:04 -0400
Received: from [200.19.162.16] ([200.19.162.16]:22656 "EHLO leao.natalnet.br")
	by vger.kernel.org with ESMTP id S261600AbVE3NhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 09:37:21 -0400
Date: Mon, 30 May 2005 10:28:20 -0300
From: Rodrigo =?ISO-8859-1?Q?Steinm=FCller?= Wanderley 
	<rwanderley@natalnet.br>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cmm@us.ibm.com,
       "Iuri [SBTVD]" <iuri@digizap.com.br>
Subject: Re: [patch 04/16] ext3: fix race between ext3 make block
 reservation and reservation window discard
Message-ID: <20050530102820.048644b2@localhost>
In-Reply-To: <20050523232016.GP27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
	<20050523232016.GP27549@shell0.pdx.osdl.net>
Organization: NatalNet - UFRN
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Natalnet-MailScanner-Information: Please contact the administrator for more information
X-Natalnet-MailScanner: Found to be clean
X-Natalnet-MailScanner-SpamCheck: not spam, SpamAssassin (score=-100,
	required 7, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Does this patch fix the "Assertion failure in log_do_checkpoint" for witch Jan Kara submitted a workaround to the list earlier?

http://lkml.org/lkml/2005/5/6/30

Thanks in advance,
  Rodrigo Wanderley
