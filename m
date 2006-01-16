Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWAPUOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWAPUOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWAPUOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:14:11 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64678 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751184AbWAPUOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:14:10 -0500
Subject: Re: [patch] networking ipv4: remove total socket usage count from
	/proc/net/sockstat
From: Lee Revell <rlrevell@joe-job.com>
To: Andy Gospodarek <andy@greyhouse.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
In-Reply-To: <20060116200432.GB14060@gospo.rdu.redhat.com>
References: <20060116200432.GB14060@gospo.rdu.redhat.com>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 15:14:05 -0500
Message-Id: <1137442446.19444.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 15:04 -0500, Andy Gospodarek wrote:
> Printing the total number of sockets used in /proc/net/sockstat is out
> of place in a file that is supposed to contain information related to
> ipv4 sockets.  Removed output for total socket usage.
> 

Um, you can't do that, it will break userspace.

Lee

