Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTDXUeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTDXUeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:34:18 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39722 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263447AbTDXUeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:34:17 -0400
Date: Thu, 24 Apr 2003 16:45:03 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, eli.carter@inet.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] patch splitting util(s)?
Message-ID: <20030424164503.A995@devserv.devel.redhat.com>
References: <3E9B2C38.4020405@inet.com> <20030414215128.GA24096@suse.de> <mailman.1050360781.7083.linux-kernel2news@redhat.com> <200304150047.h3F0lXc22483@devserv.devel.redhat.com> <20030415131043.1cdcbe44.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030415131043.1cdcbe44.rddunlap@osdl.org>; from rddunlap@osdl.org on Tue, Apr 15, 2003 at 01:10:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 15 Apr 2003 13:10:43 -0700
> From: "Randy.Dunlap" <rddunlap@osdl.org>

> | > I'm aware of patchutils.  (Check the 0.2.22 Changelog ;) )  However, 
> | > splitdiff doesn't do what I'm after, from my initial look.  Though now 
> | > that I think about it, it suggests an alternative solution.  A 
> | > 'shatterdiff' that created one diff file per hunk in a patch would give 
> | > me basically what I want.
> | 
> | I moaned at Tim until he caved in and added an '-s' option
> | couple of weeks ago. It should be in a fresh rawhide srpm.
> | 
> | Mind, you can do what you want even now, with -n (for line numbers)
> | and a little bit of sh or perl, but all concievable solutions
> | require several passes over the diff, which gets tiresome
> | if you diff 2.4.9 (RH 7.2) and 2.4.18 (RH 8.0). The -s option
> | does it in one pass.
> 
> so when does this change show up at http://cyberelk.net/tim/patchutils/ ?

Tim pointed out that the option is -a, not -s. It should be
present in 0.2.22.

-- Pete
