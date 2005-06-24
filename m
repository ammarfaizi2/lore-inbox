Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbVFXI6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVFXI6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbVFXIyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:54:03 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:15570 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S262995AbVFXIvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:51:49 -0400
Message-ID: <42BBAD9D.9030404@trex.wsi.edu.pl>
Date: Fri, 24 Jun 2005 08:52:13 +0200
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       randy_dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: Script to help users to report a BUG
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>	 <20050622120848.717e2fe2.rdunlap@xenotime.net>	 <42B9CFA1.6030702@trex.wsi.edu.pl>	 <20050622174744.75a07a7f.rdunlap@xenotime.net>	 <9a87484905062311246243774e@mail.gmail.com>	 <20050623120647.2a5783d1.rdunlap@xenotime.net>	 <9a87484905062312131e5f6b05@mail.gmail.com>	 <42BAF608.6080802@trex.wsi.edu.pl>	 <4d8e3fd305062313032c9789e8@mail.gmail.com>	 <42BAFE3E.2050407@trex.wsi.edu.pl> <4d8e3fd305062400524f0ad358@mail.gmail.com>
In-Reply-To: <4d8e3fd305062400524f0ad358@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Paolo Ciarrocchi wrote:

>One comment Michal,
>I don't like the selection of the editor, I still prefer the idea
>behind the following patch (that doesn't apply anymore)
>
>-echo "[2.] Full description of the problem/report: (press Return when done)"
>+echo "[2.] Full description of the problem/report: (end with a line
>+containing only a '.')"
>echo -e "\n[2.] Full description of the problem/report:" >> $ORT_F
>read TXT
>echo "$TXT" >> $ORT_F
>+while [ "$TXT" != "." ]  ; do
>+    read TXT
>+    echo "$TXT" >> $ORT_F
>+done
>
>Do see you the idea ? We don't need an editor to file the BUG.
>My original idea was to have a very simple and efficient script.
>
>Hope it helps.
>
>  
>
Good idea (for me). Randy what do you think about it?
