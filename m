Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318811AbSHLUa5>; Mon, 12 Aug 2002 16:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318813AbSHLUa5>; Mon, 12 Aug 2002 16:30:57 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:38154 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318811AbSHLUa5>; Mon, 12 Aug 2002 16:30:57 -0400
Message-ID: <3D581B9F.20406@namesys.com>
Date: Tue, 13 Aug 2002 00:33:35 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Andrew Morton <akpm@zip.com.au>,
       Hans Reiser <reiser@bitshadow.namesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] [PATCH] reiserfs changeset 7 of 7 to include into 2.4 tree
References: <Pine.LNX.4.44.0208121533470.3048-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You'll also find that reiserfs scales much better on machines with many 
processors with this patch in use.  It still is very coarse grained 
compared to V4, but the bitmap scanning was consuming so much CPU while 
locking out other processors that it was a performance problem for one 
person measuring our performance on 8-way machines.

-- 
Hans



