Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVD0SSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVD0SSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVD0SSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:18:34 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34729 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261915AbVD0SSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:18:31 -0400
Date: Wed, 27 Apr 2005 20:16:09 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, rnl@rnl.ist.utl.pt
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
Message-ID: <20050427181609.GA21785@electric-eye.fr.zoreil.com>
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504261402.57375.pjvenda@rnl.ist.utl.pt>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Venda (SYSADM) <pjvenda@rnl.ist.utl.pt> :
[...]
> Not being able to see the whole stacktrace on screen, we've started a 
> netconsole to investigate. Started the server and loaded it pretty bad with 
> rsyncs and such... until it crashed after just 20 minutes.
> 
> The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634!"

Is it reproducible if you disable both preempt and netconsole ?

--
Ueimor
