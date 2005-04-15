Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVDOUNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVDOUNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVDOUNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:13:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11940 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261959AbVDOUNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:13:40 -0400
Subject: Re: intercepting syscalls
From: Arjan van de Ven <arjan@infradead.org>
To: Daniel Souza <thehazard@gmail.com>
Cc: Igor Shmukler <igor.shmukler@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <e1e1d5f40504151310467d16bd@mail.gmail.com>
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
	 <e1e1d5f40504151310467d16bd@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 22:13:34 +0200
Message-Id: <1113596014.6694.87.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 13:10 -0700, Daniel Souza wrote:
> You're welcome, Igor. I needed to intercept syscalls in a little
> project that I were implementing, to keep track of filesystem changes,

I assume you weren't about tracking file content changing... since you
can't do that with syscall hijacking.. (that is a common misconception
by people who came from a MS Windows environment and did things like
anti virus tools there this way)



