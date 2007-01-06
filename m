Return-Path: <linux-kernel-owner+w=401wt.eu-S1751183AbXAFGIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbXAFGIp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 01:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbXAFGIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 01:08:45 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:38754 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751183AbXAFGIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 01:08:44 -0500
Message-ID: <368063709.01178@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 6 Jan 2007 14:08:57 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org,
       kernel@bardioc.dyndns.org
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Message-ID: <20070106060857.GA6146@mail.ustc.edu.cn>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org,
	kernel@bardioc.dyndns.org
References: <368051775.16914@ustc.edu.cn> <20070105195911.37c40e94.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105195911.37c40e94.akpm@osdl.org>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 07:59:11PM -0800, Andrew Morton wrote:
> On Sat, 6 Jan 2007 10:50:02 +0800
> Fengguang Wu <fengguang.wu@gmail.com> wrote:
> 
> > Jens: can this be a plugging issue?
> > 
> > The following command seems to block for ever:
> > # mount /home
> > 
> > It is an ext3 fs on top of /dev/md0, RAID1.
> 
> http://userweb.kernel.org/~akpm/2.6.20-rc3-mm1x.bz2 is basically 2.6.20-rc3-mm1,
> minus git-block.patch.  Can you and Torsten please test that, see if the hangs
> go away?

Yes, now it mounts OK.
Thanks.
