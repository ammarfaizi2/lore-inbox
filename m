Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUE1Mrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUE1Mrc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUE1Mrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:47:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:58772 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262766AbUE1Mpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:45:53 -0400
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by
	\000 bytes
From: Chris Mason <mason@suse.com>
To: David Madore <david.madore@ens.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040528122854.GA23491@clipper.ens.fr>
References: <20040528122854.GA23491@clipper.ens.fr>
Content-Type: text/plain
Message-Id: <1085748363.22636.3102.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 08:46:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 08:28, David Madore wrote:
> Hi folks.
> 
> I'm afraid this bug-report will be rather worthless as it is, because
> the bug has proven remarkable elusive and has defeated all my attempts
> to track it down to a precise test case or set of circumstances.  But
> since it seems important, I thought it might be worth a post anyway.
> Any help is appreciated in clarifying the circumstances which trigger
> the problem, or generally in making this report more useful.
> 
> The bottom line: I've experienced file corruption, of the following
> nature: consecutive regions (all, it seems, aligned on 256-byte
> boundaries, and typically around 1kb or 2kb in length) of seemingly
> random files are replaced by null bytes.  

The good news is that we tracked this one down recently.  2.6.7-rc1
shouldn't do this anymore.

-chris


