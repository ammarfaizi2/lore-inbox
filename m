Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTGGDQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 23:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTGGDQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 23:16:26 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:13998 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S264582AbTGGDQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 23:16:25 -0400
Date: Sun, 6 Jul 2003 20:30:58 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, barryn@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
Message-ID: <20030707033058.GA2860@ip68-4-255-84.oc.oc.cox.net>
References: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net> <20030706204630.GA2904@ip68-4-255-84.oc.oc.cox.net> <3F08DA84.7010500@cyberone.com.au> <20030706193722.79352bc3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706193722.79352bc3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 07:37:22PM -0700, Andrew Morton wrote:
> Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> Barry says the problem started with 2.5.73-mm1.  There was a reiserfs patch
> added in that kernel.
> 
> Does a `patch -R' of this fix it up?
[patch snipped]

Yes, backing that patch out fixes it.

-Barry K. Nathan <barryn@pobox.com>
