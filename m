Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWAWD3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWAWD3T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 22:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWAWD3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 22:29:19 -0500
Received: from relay02.pair.com ([209.68.5.16]:5647 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751265AbWAWD3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 22:29:18 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: OOM Killer killing whole system
Date: Sun, 22 Jan 2006 21:28:50 -0600
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1137337516.11767.50.camel@localhost> <200601202235.48352.chase.venters@clientec.com> <dr1gl8$tec$1@sea.gmane.org>
In-Reply-To: <dr1gl8$tec$1@sea.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601222129.12882.chase.venters@clientec.com>
Organization: Clientec, Inc.
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 January 2006 20:56, Kalin KOZHUHAROV wrote:
> I have two of these boards and one of them is constantly hanging, just
> simply dead. With 2.6.15 it reports failed I/O (SATA here) and mounts
> reiserfs root RO. sky2 works for me, but I had another hang, so sk98lin
> might not be the culprit.

Really? I had serious problems with mine hanging in earlier kernel revisions. 
I haven't seen a hang yet on 2.6.15, but that may be because I've not made it 
to a longer uptime because of the scsi leak. 

When I hang I get complaints about DMA timeouts / weird ATA port statuses as 
the last messages on my serial console. After that, not even SysRQ works.

Cheers,
Chase

