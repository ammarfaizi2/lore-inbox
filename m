Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161367AbWHJPzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161367AbWHJPzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161359AbWHJPzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:55:35 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:148 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1161358AbWHJPze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:55:34 -0400
Message-ID: <44DB56F4.6090908@oracle.com>
Date: Thu, 10 Aug 2006 08:55:32 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alex Tomas <alex@clusterfs.com>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
References: <1155172827.3161.80.camel@localhost.localdomain>	<20060809233940.50162afb.akpm@osdl.org>	<m37j1hlyzv.fsf@bzzz.home.net> <20060810024816.9d83c944.akpm@osdl.org>
In-Reply-To: <20060810024816.9d83c944.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Good examples don't immediately leap to mind, I'm afraid.  Maybe some of
> fs/buffer.c?  That's important and pretty tricky code in there, so it goes
> to some lengths.

fs/direct-io.c?  It has some fantastic commentary.  (Just please don't
also take inspiration from its bug/line ratio :)).

- z
