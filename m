Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262440AbSJIWmv>; Wed, 9 Oct 2002 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262443AbSJIWl2>; Wed, 9 Oct 2002 18:41:28 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35852
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262440AbSJIWim>; Wed, 9 Oct 2002 18:38:42 -0400
Subject: Re: More on O_STREAMING (goodby read pauses)
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021009222349.GA2353@werewolf.able.es>
References: <20021009222349.GA2353@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 18:43:52 -0400
Message-Id: <1034203433.794.152.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 18:23, J.A. Magallon wrote:

> But I did the test with an addition: read a 1Gb file and print an '*'
> after every 10M. Without O_STREAMING, when memory fills, the 'progress
> bar' stalls for a few seconds while pages are sent to disk.
> So the patch also favours a constant sustained rate of read from the
> disk. Very interesting for things like video edition and so on.
> I like it ;).

This is 100% the point of the patch and hopefully the point I proved
when I first posted it.

	Robert Love

