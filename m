Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271134AbTGWIEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 04:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271141AbTGWIEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 04:04:07 -0400
Received: from pop.gmx.de ([213.165.64.20]:17121 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271134AbTGWIEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 04:04:04 -0400
Date: Wed, 23 Jul 2003 13:48:44 +0530
From: Apurva Mehta <apurva@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: different behaviour with badblocks on 2.6.0-test1-mm1-07int
Message-ID: <20030723081844.GB1324@home.woodlands>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030722214253.GD1176@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722214253.GD1176@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Fedyk <mfedyk@matchmail.com> [2003-07-23 12:01]:
> Hi,
> 
> I was testing a hard drive with badblocks (from the e2fsprogs-1.34) on the
> 2.6.0-test1-mm1-07int (with Con's scheduler patch), and I noticed in vmstat
> and gkrellm that during the write passes there are reads on the same drive
> when there should only be writes.
> 
> I tried stracing badblocks, but all it showed was write() calls, and vmstat
> and gkrellm showed reads only, so it modified the behaviour.
> 
> Has anyone else seen this?

On 2.6.0-test1, gkrellm does not show any disk usage at all for
me. The disk usage krell just remains blank. vmstat reports expected
usage though.

	- Apurva
