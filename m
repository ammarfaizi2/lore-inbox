Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTJAGwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbTJAGwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:52:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:26264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262018AbTJAGwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:52:18 -0400
Date: Tue, 30 Sep 2003 23:53:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Murray J. Root" <murrayr@brain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Message-Id: <20030930235317.1d293a71.akpm@osdl.org>
In-Reply-To: <20031001051827.GE1416@Master>
References: <20031001032238.GB1416@Master>
	<20030930215512.1df59be3.akpm@osdl.org>
	<3F7A604F.1060905@cyberone.com.au>
	<20031001051827.GE1416@Master>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Murray J. Root" <murrayr@brain.org> wrote:
>

 (the linux-kernel email convention is "reply to all", btw)
 
>  test6 goes from 30 mins to 24 mins - still worse than test5 by a lot.

What sort of context switch rate are you seeing during this run?  Running
`vmstat 1' will tell.
