Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSIXLZC>; Tue, 24 Sep 2002 07:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSIXLZC>; Tue, 24 Sep 2002 07:25:02 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:47370 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261644AbSIXLZC>; Tue, 24 Sep 2002 07:25:02 -0400
Message-ID: <3D904CC2.4080607@namesys.com>
Date: Tue, 24 Sep 2002 15:30:10 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS buglet
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com> <20020924092720.GF2442@unthought.net> <20020924134816.A23185@namesys.com> <20020924100338.GH2442@unthought.net> <20020924142521.C23185@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hello!
>
>On Tue, Sep 24, 2002 at 12:03:38PM +0200, Jakob Oestergaard wrote:
>
>  
>
>>It's a question of which errors one wishes to handle, and which you
>>simply choose to ignore.
>>    
>>
>
>Yes, that's true. Reiserfs chose to not handle any HW errors, this is even
>written somewhere in our FAQ.
>
No, this is not true.  We handle IO errors.  We do not attempt to handle 
every imaginable hardware error because no one can.  If your CPU 
overheats, our code makes no effort to compensate for it.

Hans



