Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTLVLPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 06:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264910AbTLVLPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 06:15:08 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:20164
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264459AbTLVLPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 06:15:04 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew McGregor <andrew@indranet.co.nz>
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Date: Mon, 22 Dec 2003 22:15:00 +1100
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1071864709.1044.172.camel@localhost> <1071891168.1044.256.camel@localhost> <14897962.1072137278@[192.168.1.249]>
In-Reply-To: <14897962.1072137278@[192.168.1.249]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312222215.00702.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Dec 2003 21:54, Andrew McGregor wrote:
> Hmm.  Gnomemeeting has a history of strange threading issues (actually, all
> OpenH323 derived projects do).  Is there a threading change that might
> explain this?

[cc list stripped]

It's been sorted. It was a sched_yield() issue.

Con

