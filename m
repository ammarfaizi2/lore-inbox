Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSASQqC>; Sat, 19 Jan 2002 11:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSASQpv>; Sat, 19 Jan 2002 11:45:51 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:60178 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284987AbSASQpk>; Sat, 19 Jan 2002 11:45:40 -0500
Message-ID: <3C49A1C9.7090602@namesys.com>
Date: Sat, 19 Jan 2002 19:41:45 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: refuse7@poczta.fm
CC: linux-kernel@vger.kernel.org
Subject: Re: reiserFS undeletion
In-Reply-To: <20020119121610.DD9D02B5D9@pa160.grajewo.sdi.tpnet.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gniazdowski wrote:

>Hi.
>
>If reiserfs logs all operations on files, then it should be not difficould to 
>do undeletion of some file ?
>
>Today i did:
>mv UnderSusp.txt UnderSusp.avi
>
>so i ask...
>
>
>Regards Mariusz Gniazdowski
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
we only log metadata.  Running reiserfsck might get your data back 
though (or it might not, depending on whether your old data got 
overwritten.)


