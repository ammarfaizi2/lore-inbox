Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUGZWOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUGZWOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUGZWOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:14:25 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:11405 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S265960AbUGZWOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:14:24 -0400
Date: Tue, 27 Jul 2004 00:14:20 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: Klaus Dittrich <kladit@t-online.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-ID: <20040726221420.GA8789@ii.uib.no>
Mail-Followup-To: Klaus Dittrich <kladit@t-online.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040726150615.GA1119@xeon2.local.here> <20040726123702.222ae654.akpm@osdl.org> <4105633C.3080204@xeon2.local.here> <20040726133846.604cef91.akpm@osdl.org> <41057A16.60801@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41057A16.60801@xeon2.local.here>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 11:39:34PM +0200, Klaus Dittrich wrote:
> >
> >>cat /proc/sys/vm/vfs_cache_pressure shows 100.
> > 

What about trying to increase the vfs_cache_pressure which seemed
to solve what to me looks like a similar problem:

	http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&safe=off&threadm=2m9Oo-Oo-17%40gated-at.bofh.it&rnum=1&prev=/groups%3Fhl%3Den%26ie%3DUTF-8%26safe%3Doff%26q%3Djan%2Bfrode%2Boom%2Bdsmc%26spell%3D1

	http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&safe=off&threadm=2mdfi-3cC-11%40gated-at.bofh.it&rnum=2&prev=/groups%3Fq%3Djanfrode%2Boom%2Bdsmc%26ie%3DUTF-8%26hl%3Den%26btnG%3DGoogle%2BSearch


  -jf
