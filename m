Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWFTHTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWFTHTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWFTHTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:19:22 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:61429 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964926AbWFTHTV (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:19:21 -0400
Message-ID: <4497A17C.50804@namesys.com>
Date: Tue, 20 Jun 2006 00:19:24 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Chinner <dgc@sgi.com>, "Vladimir V. Saveliev" <vs@namesys.com>,
       hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: batched write
References: <20060524175312.GA3579@zero> <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de> <1149766000.6336.29.camel@tribesman.namesys.com> <20060608121006.GA8474@infradead.org> <1150322912.6322.129.camel@tribesman.namesys.com> <20060617100458.0be18073.akpm@osdl.org> <20060619162740.GA5817@schatzie.adilger.int> <4496D606.8070402@namesys.com> <20060619185049.GH5817@schatzie.adilger.int> <20060620000133.GB8770394@melbourne.sgi.com>
In-Reply-To: <20060620000133.GB8770394@melbourne.sgi.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So far we have XFS, FUSE, and reiser4 benefiting from the potential
ability to process more than 4k at a time.  Is it enough?
