Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbTIDPJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbTIDPJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:09:56 -0400
Received: from gharelay-av-smtp1.gmessaging.net ([194.51.201.2]:60050 "EHLO
	eads-av-smtp1.gmessaging.net") by vger.kernel.org with ESMTP
	id S265073AbTIDPJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:09:53 -0400
Date: Thu, 04 Sep 2003 17:09:20 +0200
From: Yann Droneaud <yann.droneaud@mbda.fr>
Subject: Re: nasm over gas?
In-reply-to: <Pine.LNX.4.53.0309041030000.3497@chaos>
To: root@chaos.analogic.com
Cc: sean neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
Message-id: <3F5755A0.5040308@mbda.fr>
Organization: MBDA
MIME-version: 1.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr-fr, fr
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4)
 Gecko/20030612
References: <20030904104245.GA1823@leto2.endorphin.org>
 <3F5741BD.5000401@mbda.fr> <Pine.LNX.4.53.0309041030000.3497@chaos>
X-OriginalArrivalTime: 04 Sep 2003 15:07:21.0704 (UTC)
 FILETIME=[3D928680:01C372F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On Thu, 4 Sep 2003, Sean Neakums wrote:
> 
> 
>>"Richard B. Johnson" <root@chaos.analogic.com> writes:
>>
>>
>>>If you decide to use gcc as a preprocessor, you can't use comments,
>>>NotGood(tm) because the "#" and some stuff after it gets "interpreted"
>>>by cpp.
>>
>>Although one could use C-style comments in this scenario, yes?
>>
> 
> 
> Sure. Then it's not assembly. It's some polymorphic conglomeration
> of crap ......... don't get me started.  If you write in assembler,
> please learn to use the assembler. Assembly is not 'C'.
> 

Comments are not useful to the assembler, it doesn't look at it ;)
So being removed by cpp or by the assembler itself does not matter for me.

GAS support C style comment and there's an option to cpp to keep comment
if you want comment in the assembler listing.

The preprocessor is 'just a kind of filter', you can preprocess your
files through m4, sed, perl, etc ... what's the problem with that ?

> Use the right tool for the right thing. Both are tools, the fact
> that you can shovel with an axe does not make the axe a shovel.
> 

...

-- 
Yann Droneaud <yann.droneaud@mbda.fr>
<ydroneaud@meuh.eu.org> <meuh@tuxfamily.org>


