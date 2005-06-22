Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVFVIrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVFVIrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVFVIod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:44:33 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:14826 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262936AbVFVIjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:39:53 -0400
Message-ID: <42B923D0.8050700@namesys.com>
Date: Wed, 22 Jun 2005 12:39:44 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Fix Reiser4 Dependencies
References: <20050619233029.45dd66b8.akpm@osdl.org> <200506200832.22260.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> <42B70A6D.7030308@namesys.com> <200506201644.10429.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> <42B7F98B.5050405@namesys.com> <42B860D9.60109@namesys.com>
In-Reply-To: <42B860D9.60109@namesys.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>Edward Shishkin wrote:
>
>  
>
>>Hello,
>>ZLIB_INFLATE/DEFLATE  will be selected by special reiser4 related
>>configuration
>>option "Enable reiser4 compression plugins of gzip family"
>>(REISER4_ZLIB), but
>>since this kind of support was discussed, it is in our working
>>repository for a while..
>>
>>Anyway thanks,
>>Edward.
>>    
>>
>
>I am sorry, are you telling him that it works for you because you have
>code that is different?  Did I misunderstand you?  How is what is in
>your working repository relevant to anybody but you?  Please supply a
>full update patch.
>
>Hans
>
>  
>

1. The patchset reiser4-replacement-broken-out.1 for 2.6.12-rc5-mm2 is 
buggy and leads to compilation errors
2. To fix this one should use the fixed patchset:
   
ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.12-rc5-mm2/reiser4-replacement-broken-out.2.tar.gz

Thanks,
Edward.

>
>  
>

