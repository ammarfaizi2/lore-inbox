Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTIOL0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTIOL0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:26:19 -0400
Received: from main.gmane.org ([80.91.224.249]:2748 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261162AbTIOL0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 07:26:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [CONFIG] zlib decompression not selectable
Date: Mon, 15 Sep 2003 13:20:59 +0200
Message-ID: <bk47ko$o94$1@sea.gmane.org>
References: <bk3dfb$g45$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
In-Reply-To: <bk3dfb$g45$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my problem is simple:
> i have both kernel 2.4.21 and 2.4.22 and want to include "zlib 
> decompression support". With "make menuconfig" i don't even see that 
> option under "Library Routines" - with "make xconfig" i see it, but it 
> disabled.

Well, the sollution is, that lib/Config.in forces CONFIG_ZLIB_INFLATE to 
be "m" in certain cases although i think, that "y" would be possible 
too. The user should be abled to select in those cases. I hope there was 
some improvement for kernel 2.6.


