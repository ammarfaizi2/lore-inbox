Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285449AbRLYKZc>; Tue, 25 Dec 2001 05:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285451AbRLYKZW>; Tue, 25 Dec 2001 05:25:22 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:60689 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285449AbRLYKZM>; Tue, 25 Dec 2001 05:25:12 -0500
Message-ID: <3C285384.3020302@namesys.com>
Date: Tue, 25 Dec 2001 13:23:00 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christian Ohm <chr.ohm@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net> <3C26F2AC.1050809@namesys.com> <20011225004459.GB3752@moongate.thevoid.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ohm wrote:

>>ReiserFS does not have a problem with large hard drives.  If you crash 
>>while writing a file, you can damage it.  Not sure if that is your 
>>problem, but maybe.
>>
>
>no just using it normally, copying files from the old to the new drive,
>running apt-get dist-upgrade etc., and then, some files contain garbage.
>only on reiserfs partitions (i copied about 3gb reiserfs to reiserfs and
>about 15gb fat32 to fat32, both under linux), and seemingly random... as i
>said, the file system looks good (right filesize etc.), the files just
>contain garbage. so i think the contents of the files gets corrupted, and
>not the file system entries for them. as for the reason why, i have no idea
>(obviously).
>
>bye & merry christmas
>christian ohm
>
>
So if I understand right, Andre Hedrick thinks it might be whatever 
driver is in the 2.4.16 kernel?

(There are several ways to read his email.)

If you can reproduce it for 2.4.17 we will eagerly debug it.

Best,

Hans


