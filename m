Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbTIDPAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTIDPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:00:47 -0400
Received: from gharelay-av-smtp2.gmessaging.net ([194.51.201.3]:53213 "EHLO
	eads-av-smtp2.gmessaging.net") by vger.kernel.org with ESMTP
	id S265234AbTIDPAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:00:37 -0400
Date: Thu, 04 Sep 2003 16:55:55 +0200
From: Yann Droneaud <yann.droneaud@mbda.fr>
Subject: Re: nasm over gas?
In-reply-to: <Pine.LNX.4.53.0309041001090.3367@chaos>
To: root@chaos.analogic.com
Cc: fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org
Message-id: <3F57527B.7050204@mbda.fr>
Organization: MBDA
MIME-version: 1.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr-fr, fr
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4)
 Gecko/20030612
References: <20030904104245.GA1823@leto2.endorphin.org>
 <3F5741BD.5000401@mbda.fr> <Pine.LNX.4.53.0309041001090.3367@chaos>
X-OriginalArrivalTime: 04 Sep 2003 14:53:56.0829 (UTC)
 FILETIME=[5DD458D0:01C372F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> 
> GAS also has macro capability. It's just "strange". However, it
> does everything MASM (/ducks/) can do. It's just strange, backwards, etc.
> It takes some getting used to.
> 
> If you decide to use gcc as a preprocessor, you can't use comments,
> NotGood(tm) because the "#" and some stuff after it gets "interpreted"
> by cpp.
> 

Yep, this is why arch/i386/boot/Makefile use -traditional flag.

In the past i rewrote all the comments with the C++ and now C99 form:
// comment
but my changes wasn't applied.

Files were hosted at http://project.meuh.eu.org/kernel/,
but they are no more on line, and i'm away from the computer where they
are backed up.

-- 
Yann Droneaud <yann.droneaud@mbda.fr>
<ydroneaud@meuh.eu.org> <meuh@tuxfamily.org>

