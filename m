Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311941AbSCOGqT>; Fri, 15 Mar 2002 01:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311943AbSCOGqK>; Fri, 15 Mar 2002 01:46:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311941AbSCOGp7>;
	Fri, 15 Mar 2002 01:45:59 -0500
Message-ID: <3C919895.2000800@mandrakesoft.com>
Date: Fri, 15 Mar 2002 01:45:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Rik van Riel <riel@conectiva.com.br>, Cort Dougan <cort@fsmlabs.com>,
        linux-kernel@vger.kernel.org
Subject: kgdb for 2.4 and 2.5, now in BK
In-Reply-To: <20020307135043.K9231@host110.fsmlabs.com> <Pine.LNX.4.44L.0203071810460.2181-100000@imladris.surriel.com> <3C87E986.50A6F3C4@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Rik van Riel wrote:
>
>>The development speed and code quality of -rmap have also gone
>>up as a consequence of moving over to bitkeeper.
>>
>heh.  Now learn kgdb.  You ain't seen nothing yet.
>
>Ever tried to use a computer with the monitor turned off?
>Kernel development without kgdb is like that.
>
>http://www.zip.com.au/~akpm/linux/kgdb.patch,v.gz contains
>kgdb patches against every kernel since 2.4.0-test-mumble.
>

Groovy.  I imported them into BK for 2.4 and 2.5 trees, and fixed up the 
merge conflicts (several patch rejections in 2.4.19-pre3), and fixed up 
the arch/i386/config.in.  BK users should pull from

    bk pull http://gkernel.bkbits.net/kgdb-2.4
or
    bk pull http://gkernel.bkbits.net/kgdb-2.5

If non-BK users are interested in my changes, feel free to grab them as 
GNU patches from
    ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.19/
    ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.5.7/


Are there any other arches that have kgdb stubs I could merge?

    Jeff



