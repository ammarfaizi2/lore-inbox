Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbTJDQJF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTJDQJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:09:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:41614 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262286AbTJDQJB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:09:01 -0400
Message-ID: <3F7EF082.3020702@namesys.com>
Date: Sat, 04 Oct 2003 20:08:34 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Max A. Krasilnikov" <pseudo@colocall.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: reiserfs one user DoS?
References: <20031004120625.GA41175@colocall.net>
In-Reply-To: <20031004120625.GA41175@colocall.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max A. Krasilnikov wrote:

>Hi!
>I have found such strange thing:
>
>pseudo@avalon at 14:04:00  ~> dd if=/dev/zero of=file bs=1 count=0 seek=1000000000000
>
>After that my Intel Celeron 800 MHz/384M RAM 60G/Seagate U6 under
>Linux-2.4.22-grsec on reiserfs was utilized 100% for more than 2 hours.
>dd process can't be killed.
>
>Is this my flow or real bug?
>
>  
>
it is fixed in reiser4.  linux has a lot of DOS vulerabilities to logged 
in users, mostly due to the ability to consume all of some resource or 
another.  forgive me for not discussing them publicly.;-)

-- 
Hans


