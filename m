Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbUKGQj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbUKGQj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUKGQj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:39:59 -0500
Received: from [62.206.217.67] ([62.206.217.67]:45205 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261249AbUKGQj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:39:57 -0500
Message-ID: <418E4FCF.5090601@trash.net>
Date: Sun, 07 Nov 2004 17:39:43 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: linux-net@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks
 amanda dumps
References: <20041104121522.GA16547@merlin.emma.line.org> <418A7B0B.7040803@trash.net> <20041104231734.GA30029@merlin.emma.line.org> <418AC0F2.7020508@trash.net> <418BE156.4020400@eurodev.net> <418BFC5C.20201@trash.net> <20041107121637.GC29510@merlin.emma.line.org>
In-Reply-To: <20041107121637.GC29510@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>IMNSHO, str* functions have no business in arbitrary data. I have a
>simple memstr() function in bogofilter that is GPL'd and can be imported
>into the kernel, I believe:
>
>  
>
It's not only strstr, it also uses simple_strtoul.
If you don't like it, send a patch.


