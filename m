Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUCSUxR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUCSUxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:53:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261168AbUCSUvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:51:31 -0500
Date: Fri, 19 Mar 2004 15:51:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Richard A. Hogaboom" <hogaboom@ll.mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Multicast reception fail when setsockopt() used to set
 SO_RCVBUF to small.
In-Reply-To: <1079728843.30591.19.camel@capella>
Message-ID: <Pine.LNX.4.53.0403191549240.5018@chaos>
References: <1079728843.30591.19.camel@capella>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Richard A. Hogaboom wrote:

> See attached bug.report file and example code files.
>
> --
> Richard A. Hogaboom
> MIT Lincoln Laboratory
> 244 Wood St.
> Lexington, MA 02420-9108
> B-389
> 781-981-0276
> hogaboom@ll.mit.edu
>

Isn't this __supposed__ to happen? You set a receive buffer
too small and it doesn't work anymore. Well ... don't do that!
What did you expect to happen?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


