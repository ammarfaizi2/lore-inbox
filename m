Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVIMRTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVIMRTq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVIMRTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:19:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30429 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964901AbVIMRTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:19:45 -0400
Date: Mon, 12 Sep 2005 21:21:46 -0400
From: Dave Jones <davej@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: Hugh Dickins <hugh@veritas.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       =?iso-8859-1?Q?M=E1rcio?= Oliveira 
	<moliveira@latinsourcetech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Tainted lsmod output
Message-ID: <20050913012146.GA15195@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Valdis.Kletnieks@vt.edu,
	Hugh Dickins <hugh@veritas.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	=?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>,
	linux-kernel@vger.kernel.org
References: <4325C713.6060908@latinsourcetech.com> <Pine.LNX.4.50.0509121129470.30198-100000@shark.he.net> <Pine.LNX.4.61.0509122039350.5019@goblin.wat.veritas.com> <Pine.LNX.4.50.0509121253300.30198-100000@shark.he.net> <Pine.LNX.4.61.0509122055520.5255@goblin.wat.veritas.com> <200509122016.j8CKGjmY029390@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509122016.j8CKGjmY029390@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 04:16:45PM -0400, Valdis.Kletnieks@vt.edu wrote:

 > Somebody had an automated log-parsing tool, and wanted to make sure there
 > were guaranteed at least 2 non-whitespace tokens on the line so they wouldn't
 > have to deal with parsing 'Tainted:       \n'?

That situation is impossible to hit. It'd be not tainted in that case.
The 'G' only gets shown if at least 1 other taint flag (typically 'M'
in my experience) is also set.

		Dave

