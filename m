Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTETAij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTETAij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:38:39 -0400
Received: from 216-42-72-152.ppp.netsville.net ([216.42.72.152]:23683 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S263364AbTETAii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:38:38 -0400
Subject: Re: 2.6 must-fix, v4
From: Chris Mason <mason@suse.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030519163306.4237dab5.rddunlap@osdl.org>
References: <20030516161717.1e629364.akpm@digeo.com>
	 <20030516161753.08470617.akpm@digeo.com>
	 <20030519163306.4237dab5.rddunlap@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053391893.9507.9.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 May 2003 20:51:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 19:33, Randy.Dunlap wrote:
> On Fri, 16 May 2003 16:17:53 -0700 Andrew Morton <akpm@digeo.com> wrote:
> 
> | fs/
> | ---
> | 
> | - Integrate Chris Mason's 2.4 reiserfs ordered data and data journaling
> |   patches.  They make reiserfs a lot safer.
> 
> What's the delay on this?  I used this code last June/July,
> and I understand that SuSE has been shipping it for awhile now.

Mostly because everyone is sick of waiting for me to finish porting and
testing in 2.5.  I removed the changes to fs/super.c from my 2.4 code,
the idea is to get submitted to 2.4 so I can lighten my load and work
harder on the 2.5 port.

We'll see, if I don't have it done before ottawa akpm can throw me in
the river.  Inclusion is a different story of course but they can't
include it if it isn't fully ported ;-)

-chris


