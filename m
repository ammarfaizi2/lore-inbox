Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVFVJMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVFVJMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbVFVJKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:10:35 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:59629 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262901AbVFVI4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:56:41 -0400
Message-ID: <42B927B8.3020802@namesys.com>
Date: Wed, 22 Jun 2005 12:56:24 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] Fix Reiser4 Dependencies
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B7F98B.5050405@namesys.com> <42B860D9.60109@namesys.com> <200506211526.03750.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200506211526.03750.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew James Wade wrote:

>Hello Edward, Hans.
>
>  
>
>>Edward Shishkin wrote:
>>    
>>
>>>ZLIB_INFLATE/DEFLATE  will be selected by special reiser4 related
>>>configuration
>>>option "Enable reiser4 compression plugins of gzip family" ...
>>>      
>>>
>Sounds promising.
>
>  
>
>>>Anyway thanks,
>>>      
>>>
>You're welcome.
>
>On June 21, 2005 02:47 pm, Hans Reiser wrote:
>  
>
>>I am sorry, are you telling him that it works for you because you have
>>code that is different?
>>    
>>
>As I understand it, when his upcoming changes are merged, base Reiser4
>would no longer depend on ZLIB_INFLATE/DEFLATE and my patch would then be
>incorrect. 
>

Yes, this will be supported optionally, plus some code to check it in 
the places
where zlib is really needed.

Edward.

>I am not in a position to know whether a code-dump or a minimal
>fix or something in-between is most appropriate for the next -mm release,
>for the moment just tweaking the Kconfig is working for me (I'm using
>Reiser4 under 2.6.12-mm1 with no further problems).
>
>HTH,
>Andrew
>
>
>  
>

