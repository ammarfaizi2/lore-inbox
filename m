Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270995AbTGVV1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271011AbTGVV1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:27:51 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35857
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270995AbTGVV1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:27:50 -0400
Date: Tue, 22 Jul 2003 14:42:53 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: different behaviour with badblocks on 2.6.0-test1-mm1-07int
Message-ID: <20030722214253.GD1176@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was testing a hard drive with badblocks (from the e2fsprogs-1.34) on the
2.6.0-test1-mm1-07int (with Con's scheduler patch), and I noticed in vmstat
and gkrellm that during the write passes there are reads on the same drive
when there should only be writes.

I tried stracing badblocks, but all it showed was write() calls, and vmstat
and gkrellm showed reads only, so it modified the behaviour.

Has anyone else seen this?

ii  e2fsprogs             1.33+1.34-WIP-2003.05 The EXT2 file system
utilities and libraries                  
