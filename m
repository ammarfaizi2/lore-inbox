Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUGULXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUGULXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 07:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUGULXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 07:23:41 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:62953 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S266449AbUGULXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 07:23:40 -0400
Date: Wed, 21 Jul 2004 13:23:36 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: List of pending v2.4 kernel bugs
Message-ID: <20040721112336.GA9537@k3.hellgate.ch>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040720142640.GB2348@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720142640.GB2348@dmt.cyclades>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004 11:26:40 -0300, Marcelo Tosatti wrote:
> I've created a directory to store known pending v2.4 problems,
> at http://master.kernel.org/~marcelo/pending-2.4-issues/ 

Multicast is still broken for big-endian architectures using via-rhine
(2.4.27-rc3). MC use on BE is rare (no bug reports!), but the bug is
fatal for anyone trying that combination. Jeff's got the patch.

A couple other drivers may be affected by the same thinko as well.

Roger
