Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbTENTxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbTENTxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:53:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:17030 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261269AbTENTxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:53:06 -0400
Date: Wed, 14 May 2003 13:01:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: drepper@redhat.com, davej@codemonkey.org.uk, ch@murgatroid.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-Id: <20030514130120.7b6371dc.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0305141246180.27329-100000@home.transmeta.com>
References: <3EC29CB2.4030707@redhat.com>
	<Pine.LNX.4.44.0305141246180.27329-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 20:05:50.0066 (UTC) FILETIME=[371BF520:01C31A54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> I don't see the point in dropping futexes except perhaps in a very 
> controlled embedded environment, but if that is the case, then a PC config 
> should just force it to "y" and not even ask the user.

How about we place these things under an additional CONFIG_TINY menu with
big fat warnings on it.  


