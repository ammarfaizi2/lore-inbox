Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTFBKau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 06:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTFBKat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 06:30:49 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:57519 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262148AbTFBKas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 06:30:48 -0400
Date: Mon, 2 Jun 2003 03:44:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: Chris Wright <chris@wirex.com>
Cc: gj@pointblue.com.pl, chris@wirex.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Early init for security modules and various
 cleanups
Message-Id: <20030602034419.3776d3b7.akpm@digeo.com>
In-Reply-To: <20030602030946.H27233@figure1.int.wirex.com>
References: <20030602025450.C27233@figure1.int.wirex.com>
	<Pine.LNX.4.44.0306021205520.27640-100000@pointblue.com.pl>
	<20030602030946.H27233@figure1.int.wirex.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2003 10:44:13.0538 (UTC) FILETIME=[E8431420:01C328F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chris@wirex.com> wrote:
>
> security_capable() returns 0 if that capability bit is set. 

That's just bizarre.  Is there any logic behind it?


