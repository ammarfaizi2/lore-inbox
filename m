Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTEHB2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 21:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTEHB2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 21:28:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:31807 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264388AbTEHB2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 21:28:14 -0400
Date: Wed, 7 May 2003 18:40:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: garbled oopsen
Message-Id: <20030507184054.684e2bd0.akpm@digeo.com>
In-Reply-To: <20030507180530.23d0e780.rddunlap@osdl.org>
References: <20030507180530.23d0e780.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 May 2003 01:40:44.0093 (UTC) FILETIME=[D730E6D0:01C31502]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> I have several oopses that are garbled.

Use kgdb.

> Can these be cleaned up in any reasonable way?

It needs some additional spinlock in there.  People have moaned for over a
year, patches have been floating about but nobody has taken the time to
finish one off and submit it.

It's never bothered me, because availability of a serial console equates to
availability of kgdb.

> Any suggestions?

A Greek-to-English dictionary?


