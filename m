Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTFKSlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 14:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTFKSlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 14:41:52 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15335 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263610AbTFKSlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 14:41:51 -0400
Date: Wed, 11 Jun 2003 11:56:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [2.5.70-mm8] NETDEV WATCHDOG: eth0: transmit timed out
Message-Id: <20030611115626.26ddac3a.akpm@digeo.com>
In-Reply-To: <200306111725.49952.schlicht@uni-mannheim.de>
References: <20030611013325.355a6184.akpm@digeo.com>
	<200306111356.52950.schlicht@uni-mannheim.de>
	<200306111516.46648.schlicht@uni-mannheim.de>
	<200306111725.49952.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 18:55:34.0780 (UTC) FILETIME=[0A2B5BC0:01C3304B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> OK, I've found it...!

Thanks.

> After reverting the pci-init-ordering-fix everything works as expected 
> again...

Damn.  That patch fixes other bugs.  i386 pci init ordering is busted.
