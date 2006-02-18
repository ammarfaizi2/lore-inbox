Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWBRTxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWBRTxy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 14:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWBRTxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 14:53:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932133AbWBRTxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 14:53:52 -0500
Date: Sat, 18 Feb 2006 19:53:47 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sysfs representation of stacked devices (dm/md)
Message-ID: <20060218195347.GU12169@agk.surrey.redhat.com>
Mail-Followup-To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
	device-mapper development <dm-devel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <43F60F31.1030507@ce.jp.nec.com> <20060217194249.GO12169@agk.surrey.redhat.com> <43F6769C.5010505@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F6769C.5010505@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 08:21:32PM -0500, Jun'ichi Nomura wrote:
> Speaking about the efficiency, 'dmsetup ls --tree' works well.
> However, I haven't yet found a efficient way to implement
> 'dmsetup info --tree -o inverted dm-0', for example.
 
Indeed - but what needs this that doesn't also need to scan
everything?    mount?

Alasdair
-- 
agk@redhat.com
