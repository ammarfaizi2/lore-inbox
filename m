Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293552AbSCSDfh>; Mon, 18 Mar 2002 22:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293619AbSCSDf1>; Mon, 18 Mar 2002 22:35:27 -0500
Received: from [211.238.181.68] ([211.238.181.68]:59661 "EHLO
	mail.digitaldreamstudios.net") by vger.kernel.org with ESMTP
	id <S293552AbSCSDfS>; Mon, 18 Mar 2002 22:35:18 -0500
Message-ID: <3C96B1FB.BFE2C122@nownuri.net>
Date: Tue, 19 Mar 2002 12:35:23 +0900
From: SeongTae Yoo <alloying@nownuri.net>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: file listing problem in smbfs, kernel 2.4.18
In-Reply-To: <Pine.LNX.4.44.0203182148020.15143-100000@cola.teststation.com>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Urban Widmark wrote:
> 
> You could also try the smbfs unicode patch for 2.4.18, and see if that
> changes anything.
>     http://www.hojdpunkten.ac.se/054/samba/index.html
>     (Note the additional samba patch and mount flags needed)

I tried it just before, but same result.

> 
> Do you have trouble with this set of files elsewhere?
> 
> If you have more than one server, does it make any difference if you copy
> the files to some other server?

I have already tested before the previous posting, but no difference.
However, when the files are copied to a fat32 partition of w2k server,
all files listed.

> Does it matter how deep in the file hierarchy the dir is, for example is
> there any difference between these two:
>    //server/share/some/long/path/the-dir-that-fails/
>    //server/share/the-dir-that-fails/

The original depth is

    //server/e$/1st-dir/2nd-dir/3rd-dir/

tested depths are

    //server/e$/2nd-dir/3rd-dir/     or
    //server/e$/3rd-dir/

but no difference.


If you need some other tests, I will do it.
