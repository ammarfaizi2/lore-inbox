Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWJYTDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWJYTDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWJYTDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 15:03:01 -0400
Received: from mx1.suse.de ([195.135.220.2]:3531 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161372AbWJYTDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 15:03:00 -0400
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strange work_notifysig code since 2.6.16
References: <20061024231921.GA25130@tsunami.ccur.com>
	<20061025054806.GP6412@waste.org>
	<20061025142923.GA20833@tsunami.ccur.com>
From: Andi Kleen <ak@suse.de>
Date: 25 Oct 2006 21:02:58 +0200
In-Reply-To: <20061025142923.GA20833@tsunami.ccur.com>
Message-ID: <p73r6wwkyl9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> writes:

> > I suspect this won't link with CONFIG_VM86 disabled because save_v86_state
> > goes away. I think we just need to move the #endif up a few lines.
> 
> Hi Matt,
> Since that also makes the 'then' and 'else' branches identical, perhaps
> this patch would be better .. it eliminates the VM86 test entirely when
> CONFIG_VM86=n.
> 
> Boot tested with CONFIG_VM86=y.

Added.

-Andi
