Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTI2UPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTI2UPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:15:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34321 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264193AbTI2UPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:15:30 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PROBLEM] [2.6.0-test6] Stale NFS file handle
Date: 29 Sep 2003 20:06:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bla3bb$3l2$1@gatekeeper.tmr.com>
References: <200309282031.54043.MalteSch@gmx.de> <20030928184841.GL532@neon>
X-Trace: gatekeeper.tmr.com 1064865963 3746 192.168.12.62 (29 Sep 2003 20:06:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030928184841.GL532@neon>,
Axel Siebenwirth  <axel@pearbough.net> wrote:

| Are you using mount options when mounting the NFS volume?
| I had this problem when I used rsize=8192 and wsize=8192 as nfs mount
| options. Just left them out and everything was fine again.

This is useful as a test and problem identification, but if you're
transferring significant data between systems other than those directly
connected with a low latency connection you do see performance loss.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
