Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVISJTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVISJTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVISJTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:19:09 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:33736 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932398AbVISJTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:19:08 -0400
Message-ID: <432E8282.6060905@namesys.com>
Date: Mon, 19 Sep 2005 13:18:58 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: ReiserFS List <reiserfs-list@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <20050918110658.GA22744@infradead.org>
In-Reply-To: <20050918110658.GA22744@infradead.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Christoph Hellwig wrote:
> I threw in your new codedrop into a compilation and the byte-order
> mess is _still_ now sorted out.  

Did compiling notice this mess?
We used to compile with C=1. Should we compile somehow else before sending code out?

> Please kill the d* as struct type
> crap and just use __le types directly.
> 
ok

> Also lots of "memset with byte count of 0" warnings from sparse.
> 

Running make C=1 fs/reiser4/ with sparse from http://www.codemonkey.org.uk/projects/git-snapshots/sparse/sparse-2005-09-19.tar.gz
does not produce any warnings.
Would you please prompt how to make sparse to complain?
