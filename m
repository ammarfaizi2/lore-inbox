Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbUDSJFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 05:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264316AbUDSJFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 05:05:14 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:4367 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264312AbUDSJFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 05:05:08 -0400
Message-ID: <40839688.4010902@aitel.hist.no>
Date: Mon, 19 Apr 2004 11:06:16 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
In-Reply-To: <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:
> Hi, Trond Myklebust wrote:
> 
> 
>>As for blanket statements like the above: I have seen no evidence yet
>>that they are any more warranted in 2.6.x than they were in 2.4.x.
> 
> 
> Oh, I saw the problem too: a slow client couldn't do full-size reads from
> a fast server because the buffer on the client's network card was just 8k.
> 
You can force nfs to use smaller packets, useful for those who
have to use udp because the server doesn't support nfs over tcp.
Try 8k, or even 4k.

Helge Hafting

