Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVGLUok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVGLUok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVGLUoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:44:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5097 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262397AbVGLUoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:44:15 -0400
Message-ID: <42D42B91.3080608@us.ibm.com>
Date: Tue, 12 Jul 2005 13:44:01 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com> <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com> <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <17107.64629.717907.706682@tut.ibm.com> <Pine.BSO.4.62.0507121935500.6919@rudy.mif.pg.gda.pl> <17108.1906.628755.613285@tut.ibm.com> <Pine.BSO.4.62.0507122026520.6919@rudy.mif.pg.gda.pl> <17108.5721.202275.377020@tut.ibm.com> <Pine.BSO.4.62.0507122127300.6919@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0507122127300.6919@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:

> On Tue, 12 Jul 2005, Tom Zanussi wrote:
> [..]
>
>> > This is much more simpler and much better for control (also from 
>> point of
>> > view caching bugs in agregator code -> also from point of view kernel
>> > stability).
>> >
>> > Also .. probably some code for handle i.e. counters cen be the same as
>> > existing code in current kernel.
>> > Probably some "atomic" (and/or simpler) agregators can be usefull 
>> in other
>> > places in kernel for collecting some data during all time when system
>> > works .. so code for handle this can be reused in non-ocasinal
>> > tracing/measuring.
>> > And again: all without things like relayfs.
>>
>> Well, you should check out the sytemtap project.  It's basically a
>> DTrace clone which is already doing these kinds of things with
>> kprobes, and it's using relayfs...
>
>
> Probaly by this it will be harder to say "KProbes it is Solaris DTrace
> clone".
>
I have not looked at Dtrace code but based on their USENIX paper looks 
like we can not call Systemtap as Dtrace clone without a buffering 
scheme like relayfs.

> kloczek



