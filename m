Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTJXTnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTJXTnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:43:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:61340 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262560AbTJXTnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:43:18 -0400
Date: Fri, 24 Oct 2003 12:43:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: nico-kernel@schottelius.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 3c59x problem with 2.4.6-test[34]
Message-Id: <20031024124356.212fc590.akpm@osdl.org>
In-Reply-To: <20031024193402.GA985@ip68-0-152-218.tc.ph.cox.net>
References: <20030907212348.GA836@ip68-0-152-218.tc.ph.cox.net>
	<20030929151827.GB862@ip68-0-152-218.tc.ph.cox.net>
	<20031015183505.GA963@ip68-0-152-218.tc.ph.cox.net>
	<20031017235325.GA957@ip68-0-152-218.tc.ph.cox.net>
	<20031018122708.GA401@schottelius.org>
	<20031018041448.6362faee.akpm@osdl.org>
	<20031024193402.GA985@ip68-0-152-218.tc.ph.cox.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> Okay.  First an odd part.  When the card does not work, I didn't get
>  anything in the syslog with debug=7, but I did get plenty when it works.

Well that's a big hint.  If no debug output comes out then the driver
simply isn't being executed.  You'll need to investigate and report on this
further.  Make sure that you've set `dmesg -n 7' of course...



