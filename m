Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbRFYJXv>; Mon, 25 Jun 2001 05:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbRFYJXl>; Mon, 25 Jun 2001 05:23:41 -0400
Received: from james.kalifornia.com ([208.179.59.2]:10805 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S262915AbRFYJX0>; Mon, 25 Jun 2001 05:23:26 -0400
Message-ID: <3B370250.1050305@kalifornia.com>
Date: Mon, 25 Jun 2001 02:20:16 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010623
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marty Leisner <leisner@rochester.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mounting a fs in two places at once?
In-Reply-To: <200106250212.WAA05336@soyata.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marty Leisner wrote:

>
>/dev/hda10 on /mnt type ext2 (rw)
>/dev/hda10 on /home type ext2 (rw)
>
>
>Is this a feature or a bug?
>

Feature.  It actually makes it quite nice when you want to allow 
chrooted user(s) access to a common directory, you just mount a 
partition in all the users home dirs.

-b

-- 
:    __o
:   -\<,
:   0/ 0
-----------



