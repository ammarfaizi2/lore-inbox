Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVFWFPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVFWFPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVFWFPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:15:20 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:55523 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262375AbVFWFO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:14:57 -0400
Message-ID: <42BA454C.3090500@namesys.com>
Date: Wed, 22 Jun 2005 22:14:52 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <20050622053450.GA28228@infradead.org>
In-Reply-To: <20050622053450.GA28228@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>
>
>  
>
>>What is wrong with having one file in the FS use a write only plugin, in
>>which the encrypion key is changed with every append in a forward but
>>not backward computable manner, and in order to read a file you must
>>either have a key that is stored on another computer or be reading what
>>was written after the moment of cracking root?
>>    
>>
>
>Because root can read kernel memory this is completely useless :)
>  
>
You missed the point of it rather nicely.  If root can read kernel
memory, that only gets it the appends made after the point in time of
cracking root.


It is not my idea, and it is not yet present in our code, let me not
seem to take credit for it though I think it a good idea.
