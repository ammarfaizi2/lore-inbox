Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUGUL2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUGUL2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 07:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUGUL2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 07:28:22 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:38840 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S266492AbUGUL2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 07:28:14 -0400
Date: Wed, 21 Jul 2004 13:28:03 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc2: 'Invalid MAC address' error with via-rhine driver
Message-ID: <20040721112803.GB9537@k3.hellgate.ch>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1090369207.841.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090369207.841.1.camel@mindpipe>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004 20:20:17 -0400, Lee Revell wrote:
> I get the following error trying to load the via-rhine module with
> kernel 2.6.8-rc2.  I did not get this error with 2.6.8-rc1-mm1.
> 
> Jul 20 20:11:13 mindpipe kernel: via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
> Jul 20 20:11:13 mindpipe kernel: Invalid MAC address for card #0
> Jul 20 20:11:13 mindpipe kernel: via-rhine: probe of 0000:00:12.0 failed with error -5

The problem is known (see my other postings), but the cause is not. I
cannot reproduce the problem, if you are willing to conduct a binary
search with no more than 4 steps, I'll send you the relevant patches.

Roger
