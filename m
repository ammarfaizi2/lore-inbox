Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbTKKCUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 21:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTKKCUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 21:20:39 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:44551
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264182AbTKKCUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 21:20:38 -0500
Date: Mon, 10 Nov 2003 18:20:41 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Joseph Shamash <info@avistor.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
Message-ID: <20031111022041.GD2014@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Joseph Shamash <info@avistor.com>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	linux-kernel@vger.kernel.org
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au> <HBEHKOEIIJKNLNAMLGAOCECPDKAA.info@avistor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HBEHKOEIIJKNLNAMLGAOCECPDKAA.info@avistor.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 06:10:15PM -0800, Joseph Shamash wrote:
> Hello Peter,
> 
> Thank you for your quick reply.
> 
> Another Q.
> 
> What is the maximum partition size in TBs that 2.6 can handle?

Are you using hardware raid that shows the entire array like one disk that
should be partitioned, or do you want to use linux software raid?

If you're using hardware raid, you should consider what Peter said in his
message.

> What is the maximum file size?

That depends on what filesystem you want to use.  With ext2/3 it varies
between 16GB (with 1KB blocks) and 1 or 2 TB (with 4KB blocks) per file.

Other filesystems have similair limits.  There have been several
comparisons, and a quick google search should bring up a few.  Try "linux
filesystem comparison"

Mike
