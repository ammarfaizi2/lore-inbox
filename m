Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270314AbTGRTWv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270319AbTGRTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:22:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63988 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270314AbTGRTWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:22:50 -0400
Subject: Re: pthread in linux
From: Robert Love <rml@tech9.net>
To: ghyan@cs.dartmouth.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200307181437.01273.ghyan@cs.dartmouth.edu>
References: <200307181437.01273.ghyan@cs.dartmouth.edu>
Content-Type: text/plain
Message-Id: <1058557385.6689.1810.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 18 Jul 2003 12:43:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-18 at 11:37, Guanhua Yan wrote:

> does anyone know the default time slice for each pthread execution in linux? 
> is it 1/60 sec? thanks!

It is the same as the default process timeslice, and that would depend
on your kernel version.

Currently, in 2.6.0-test1, it ranges from 10ms to 200ms, depending on
priority, with a default of 200ms.

	Robert Love


