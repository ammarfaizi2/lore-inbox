Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135820AbRDYGay>; Wed, 25 Apr 2001 02:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135821AbRDYGan>; Wed, 25 Apr 2001 02:30:43 -0400
Received: from james.kalifornia.com ([208.179.59.2]:29793 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S135820AbRDYGab>; Wed, 25 Apr 2001 02:30:31 -0400
Message-ID: <3AE65FED.5080407@kalifornia.com>
Date: Tue, 24 Apr 2001 22:26:05 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; rv:0.8.1+) Gecko/20010420
X-Accept-Language: en
MIME-Version: 1.0
To: ttel5535@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.21.0104241508370.11387-100000@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Telensky wrote:

<snip>

>But, what I should say to the network security, is that AFAIK in the most
>of linux distributions the standard daemons (httpd, sendmail) are run as
>root! Having multi-user system or not! Why? For only listening to a port
><1024? Is there any elegant solution?
>

Yes, most daemons have the ability to switch user ID once they have 
bound tho the port.  Additionally, support is starting to show up for 
capabilities.  I know that ProFTPD has support.  Now, assuming it is 
running on a newer kernel, it never needs to be root, because it has 
been granted the capability to open a low port.  Even if it is cracked, 
it cannot do other things like . . . insert a kernel module, . . . 
overwrite /etc/passwd . . . . . etc

-b

-- 
Three things are certain:
Death, taxes, and lost data
Guess which has occurred.
- - - - - - - - - - - - - - - - - - - -
Patched Micro$oft servers are secure today . . . but tomorrow is another story!



