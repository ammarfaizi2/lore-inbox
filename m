Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263916AbTH1LP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 07:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263935AbTH1LP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 07:15:27 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:25713 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263916AbTH1LPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 07:15:24 -0400
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308262241580.2728-300000@neptune.local>
References: <Pine.LNX.4.44.0308262241580.2728-300000@neptune.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1062069306.17230.117.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Aug 2003 12:15:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-08-26 at 21:43, Pascal Schmidt wrote:

> fsx1.c (from 2001, whoa) is the one that causes the bad problems,
> while fsx2.c only yields tons of messages but no BUG().

Many thanks --- I was able to reproduce this very easily, and I know of
one or two very unusual things that fsx does which might well be the
trigger here.  I'll let you know how things go.

Cheers,
 Stephen

