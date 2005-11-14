Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVKNHwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVKNHwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVKNHwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:52:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40938 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750978AbVKNHwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:52:53 -0500
Subject: Re: ADI Blackfin patch for kernel 2.6.14
From: Arjan van de Ven <arjan@infradead.org>
To: Luke Yang <luke.adi@gmail.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <489ecd0c0511132334rc0d8a18n9ccf1bdd30d564a0@mail.gmail.com>
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	 <20051107165928.GA15586@kroah.com> <20051107235035.2bdb00e1.akpm@osdl.org>
	 <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
	 <20051112214741.GB16334@kroah.com>
	 <489ecd0c0511132334rc0d8a18n9ccf1bdd30d564a0@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 08:52:44 +0100
Message-Id: <1131954765.2821.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The process is like maintaining any other part of the kernel:
> >   - Try to make sure it works on all releases (harder to do with a full
> >     arch, I know, but not impossible.)
> 
>   Does this include all the rc releases? and the 2.6.14.x releases?
> 
> >   - keep it up to date with bugfixes and the such
> 
>   So the process is: when kernel release a new version, we should
> update our arch related files to the new kernel, then send you the
> patch. Am I right?

well the idea is that you fix things BEFORE the kernel is released for
final, so that the final releases work out of the box (well out of
kernel.org). This implies that you sort of track the git tree on a
regular basis, but at minimum look at the first -rc kernel.

