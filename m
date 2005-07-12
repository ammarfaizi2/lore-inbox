Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVGLVYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVGLVYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVGLVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:03:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33235 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262429AbVGLVCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:02:32 -0400
Message-ID: <42D42FE1.3080600@us.ibm.com>
Date: Tue, 12 Jul 2005 14:02:25 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com> <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com> <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <17107.64629.717907.706682@tut.ibm.com> <Pine.BSO.4.62.0507121935500.6919@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0507121935500.6919@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:

> On Tue, 12 Jul 2005, Tom Zanussi wrote:
>
>> =?ISO-8859-2?Q?Tomasz_K=B3oczko?= writes:
>> > On Tue, 12 Jul 2005, Tom Zanussi wrote:
>> [...]
>>
>> >
>> > OK .. "so you can say better is stop flushing buffers on measure which
>> > wil take day or more" ? :_)
>> > Some DTrace probes/technik are specialy prepared for long or evel very
>> > long time experiment wich will only prodyce few lines results on 
>> end of
>> > experiment.
>> > Look at DTrace documentation for speculative tracing:
>> > http://docs.sun.com/app/docs/doc/817-6223/6mlkidli7?a=view
>> >
>

How do you propose to implement speculative tracing without a buffer to 
hold the data, when data needs to stay in the kernel for a while before 
we decide to commit or discard?

>>
>> [...]
>
> kloczek



