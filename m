Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVF0Uji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVF0Uji (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVF0Uit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:38:49 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:6130 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261754AbVF0Uhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:37:35 -0400
Message-ID: <42C06390.5070609@namesys.com>
Date: Mon, 27 Jun 2005 13:37:36 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       vitaly@thebsh.namesys.com
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org> <20050627193051.GA22208@infradead.org>
In-Reply-To: <20050627193051.GA22208@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>>reiser4
>>    
>>
>
>sparse isn't to happy about this:
>
>hch@macfly:/work/linux-2.6.12$ make C=1 SUBDIRS=fs/reiser4/ >/dev/null 2>err.log && wc -l err.log
>2286 err.log
>
>The log is at http://verein.lst.de/~hch/linux-2.6.12-mm2-fs-reiser4-errors.log
>
>
>  
>
Thanks for telling us about sparse, we will work on fixing these. 
Vitaly, can you do this?

Hans
