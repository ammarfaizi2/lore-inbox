Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbWFILYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWFILYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 07:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWFILYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 07:24:31 -0400
Received: from [80.71.248.82] ([80.71.248.82]:13543 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S965233AbWFILYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 07:24:30 -0400
X-Comment-To: Christoph Hellwig
To: Christoph Hellwig <hch@infradead.org>
Cc: Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 15:26:26 +0400
In-Reply-To: <20060609091327.GA3679@infradead.org> (Christoph Hellwig's message of "Fri, 9 Jun 2006 10:13:27 +0100")
Message-ID: <m364jafu3h.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Christoph Hellwig (CH) writes:

 CH> If you guys want big storage on linux please help improving the filesystems
 CH> design for that, e.g. jfs or xfs instead of showhorning it onto ext3 thus
 CH> both making ext3 less reliable for us desktop/small server users and not get
 CH> the full thing for the big storage people either.

proposed patches don't touch existing code paths.
extents may be enabled/disabled on per-file basis.

thanks, Alex
