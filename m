Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVFWU2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVFWU2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVFWUYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:24:50 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:43954 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S262880AbVFWUXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:23:38 -0400
Message-ID: <42BAFE3E.2050407@trex.wsi.edu.pl>
Date: Thu, 23 Jun 2005 20:23:58 +0200
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       randy_dunlap <rdunlap@xenotime.net>
Subject: Re: Script to help users to report a BUG
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>	 <20050622120848.717e2fe2.rdunlap@xenotime.net>	 <42B9CFA1.6030702@trex.wsi.edu.pl>	 <20050622174744.75a07a7f.rdunlap@xenotime.net>	 <9a87484905062311246243774e@mail.gmail.com>	 <20050623120647.2a5783d1.rdunlap@xenotime.net>	 <9a87484905062312131e5f6b05@mail.gmail.com>	 <42BAF608.6080802@trex.wsi.edu.pl> <4d8e3fd305062313032c9789e8@mail.gmail.com>
In-Reply-To: <4d8e3fd305062313032c9789e8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Paolo Ciarrocchi wrote:

>
>Jus tried, it works well.
>
>How about adding this patch, or something like that ?
>
>--- ort.sh	2005-06-23 19:45:54.000000000 +0200
>+++ ort-new.sh	2005-06-23 21:56:25.655604560 +0200
>@@ -507,6 +507,7 @@ send_r() {
> 	    then
> 		echo -e "\nPlease email $ORT_F to linux-kernel@vger.kernel.org"
> 		echo -e "or some other appropriate Linux mailing list."
>+		echo -e "And please, use this information to file a BUG in the
>kernel Bugzilla you'll find at bugme.osdl.org. Thanks "
> 	        END=1
>         fi
>     done
>
>It seems to that there is a general agreement that all the BUG should
>be filed in bugzilla too.
>
>  
>
Ok. Good idea.
How can we do automatic posts on bugzilla? Is it possible?

For future:
We need something like ORT-HOWTO in Documentation.

Regards,
Micha³ piotrowski
