Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTE1Xom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTE1Xom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:44:42 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:45955 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261702AbTE1Xol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:44:41 -0400
Date: Wed, 28 May 2003 16:55:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: lawrence@the-penguin.otak.com, linux-kernel@vger.kernel.org
Subject: Re: OOPs report
Message-Id: <20030528165532.770a2c24.akpm@digeo.com>
In-Reply-To: <20030528230559.GA7810@suse.de>
References: <20030528151620.GA21579@the-penguin.otak.com>
	<20030528155342.45d1e437.akpm@digeo.com>
	<20030528230559.GA7810@suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 23:57:57.0839 (UTC) FILETIME=[F67DF5F0:01C32574]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Wed, May 28, 2003 at 03:53:42PM -0700, Andrew Morton wrote:
> 
>  > yes, sorry.  -mm has extra list_head debugging goodies, and they detect
>  > bugs in devfs.
> 
> I was wondering about that stuff actually..  Has it tripped up
> anything other than devfs ?

Not as far as I know.

> It does look quite useful.

Yes.  It's a matter of finding an appropriate CONFIG_DEBUG_FOO to wrap it
in.

