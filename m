Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTJ3L7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 06:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTJ3L7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 06:59:20 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:39590 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262386AbTJ3L7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 06:59:18 -0500
Message-ID: <3FA0FD15.40207@namesys.com>
Date: Thu, 30 Oct 2003 14:59:17 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com> <20031030081739.GB1399@wiggy.net>
In-Reply-To: <20031030081739.GB1399@wiggy.net>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't need extended attributes, you just needs files and 
directories....  www.namesys.com/v4.html says more.

Hans

Wichert Akkerman wrote:

>Previously Hans Reiser wrote:
>  
>
>>It is true that there are many features, such as an automatic text 
>>indexer, that belong in user space, but the basic indexes (aka 
>>directories) and index traversal code belong in the kernel.
>>    
>>
>
>Sure, but if you have a kernel which supports arbitraty extended
>attributes for files you don't need much more kernel support. You
>can implement things like metadata for files and query languages on
>top of that in userspace. If you modify applications to (also) put some
>metadata (meta tags from html pages, document properties from office
>documents, etc.) in those extended attributes you might already be where
>microsoft is going.
>
>You only would need some kernel interaction if you want to keep an
>updated index of file contents (dnotify for a while filesystem and
>reindexing whole files instead of blocks doesn't sound very attractive).
>
>Wichert.
>
>  
>


-- 
Hans


