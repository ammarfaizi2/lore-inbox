Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266338AbTGJL7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269226AbTGJL7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:59:43 -0400
Received: from fmr01.intel.com ([192.55.52.18]:24047 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266338AbTGJL7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:59:42 -0400
Message-ID: <3F0D583E.8070307@intel.com>
Date: Thu, 10 Jul 2003 15:12:46 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: PATCH: seq_file interface to provide large data chunks
References: <3F0D217B.4040900@intel.com> <1057835373.8028.0.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057835373.8028.0.camel@dhcp22.swansea.linux.org.uk>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
I analyzed 2 latest patches from www.kernel.org:
patch-2.4.22-pre4 and patch-2.4.22-pre3-ac1.

-pre4 do not touch seq_file;

-pre3-ac1 corrects spelling and adds single_xxx functions. There is no 
conflict between this patch and my one. I verified, they do apply in any 
order (with some offset).

Vladimir.

Alan Cox wrote:

>On Iau, 2003-07-10 at 09:19, Vladimir Kondratiev wrote:
>  
>
>>seq_file interface, as it exist in last official kernel, never provides 
>>more then one page for each 'read' call. Old read_proc_t did loop to 
>>fill more than one page.
>>    
>>
>
>There is a merge of Al's additional seq_file stuff to 2.4 floating
>around (its in -ac for one) that may be a better thing to merge instead
>if we want it 
>
>Al ?
>
>  
>


