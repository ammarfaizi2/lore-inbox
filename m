Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315847AbSEGOyY>; Tue, 7 May 2002 10:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315849AbSEGOyX>; Tue, 7 May 2002 10:54:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:53005 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315847AbSEGOyW>; Tue, 7 May 2002 10:54:22 -0400
Message-ID: <3CD7DBC8.3050602@evision-ventures.com>
Date: Tue, 07 May 2002 15:51:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Christoph Hellwig <hch@infradead.org>, Osamu Tomita <tomita@cinet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE CD-ROM PIO mode
In-Reply-To: <Pine.SOL.4.30.0205071624140.14960-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Bartlomiej Zolnierkiewicz napisa?:
> while we are here, I think that drivers shouldn't take
> requests < hardsect_size, it should be handled by block layer

There could be clever beasts which do (over)buffering...
like ide-cdrom indeed does.

